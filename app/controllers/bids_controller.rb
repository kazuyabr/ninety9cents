class BidsController < ApplicationController

	# Bids will go up in one dollar increments, note all amounts are in cents (integers)
	INCREMENT = 100

	def new
		@bid = Bid.new
	end

	# The logic in this method needs to be pulled out and placed into the respective model
	def create
		# Set up the new bid
		@bid = Bid.new
		@bid.amount = (bid_params[:amount].to_f * 100).to_i # Convert to integer and handle input with or without cents
		@time = Time.now
		@bid.bid_time = @time
		@bid.user_id = @current_user.id
		@bid.auction_id = session[:auction_id]

		# Fetch the auction and its associated bids
		@auction = Auction.find(session[:auction_id])
		@existing_bids = Bid.where(:auction_id => session[:auction_id])

		# Add the auction to the bidder's watch list
		@watcher = Watcher.new
		@watcher.auction_id = session[:auction_id]
		@watcher.user_id = @current_user.id
		
		# Create a new bid history entry
		@bid_history = BidHistory.new

		if @auction.status == 'live'
			if @auction.user_id == @current_user.id
				flash.notice = 'You cannot bid on your own auction'
				redirect_to auction_path(session[:auction_id]) and return
			else
				if @bid.amount
					if @existing_bids.length == 0
						if @bid.amount >= @auction.start_price
							@auction.current_bid = @auction.start_price
							@bid_history.amount = @auction.current_bid
							@bid_history.bid_time = @time
							@bid_history.username = @current_user.username
							@bid_history.auction_id = session[:auction_id]
							@bid_history.save
							@auction.save
							flash.notice = 'You are the first bidder'
						else
							flash.notice = 'Bid must be at least equal to the starting price'
							render :new and return
						end
					else
						@highest_bid = Utilities.get_highest_bid(@existing_bids)
						if @highest_bid.user_id == @current_user.id
							if @bid.amount > @highest_bid.amount
								flash.notice = "You have increased your maximum bid to #{Utilities.convert_to_price(@bid.amount)}"
							else
								flash.notice = "The amount entered needs to be higher than your last maximum bid, please enter an amount greater than #{Utilities.convert_to_price(@highest_bid.amount)}"
								render :new and return
							end
						else
							if @bid.amount > @highest_bid.amount # There is a new high bidder
								@auction.current_bid = @highest_bid.amount + INCREMENT
								@bid_history.amount = @auction.current_bid
								@bid_history.bid_time = @time
								@bid_history.username = @current_user.username
								@bid_history.auction_id = session[:auction_id]
								@bid_history.save
								@auction.save
								flash.notice = "You are now the high bidder, your maximum bid is #{Utilities.convert_to_price(@bid.amount)}"
							elsif @bid.amount <= @highest_bid.amount && @bid.amount > @auction.current_bid
								# The bid should increase by the challenging bidder plus the increment
								if @highest_bid.amount - @bid.amount < INCREMENT # Do not want to push the high bid over by less than the INCREMENT as this would increase the maximum bid without asking the high bidder to approve
									@auction.current_bid = @highest_bid.amount
								else
									@auction.current_bid = @bid.amount + INCREMENT
								end
								@bid_history.amount = @auction.current_bid
								@bid_history.bid_time = @time
								@bid_history.username = @current_user.username
								@bid_history.auction_id = session[:auction_id]
								@bid_history.save
								@auction.save
								flash.notice = 'You were outbid, please enter a higher amount'
							else
								flash.notice = 'Bid too low, please enter a higher amount'
								render :new and return
							end
						end
					end
				else
					flash.notice = 'No amount entered, please try again'
					render :new and return
				end

				if @bid.save
					@watcher.save
					redirect_to auction_path(session[:auction_id])
				else
					flash.notice = 'Bid not entered, please try again'
					render :new and return
				end
			end
		else
			flash.notice = 'Sorry, bidding for this auction has ended'
			redirect_to auction_path(session[:auction_id])
		end

	end

	private
	
	def bid_params
		params.require(:bid).permit(:amount)
	end

end
