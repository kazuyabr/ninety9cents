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
		@bid.bid_time = Time.now
		@bid.user_id = @current_user.id
		@bid.auction_id = session[:auction_id]

		# Fetch the auction and its associated bids
		@auction = Auction.find(session[:auction_id])
		@existing_bids = Bid.where(:auction_id => session[:auction_id])
		
		if @auction.user_id == @current_user.id
			flash.notice = 'You cannot bid on your own auction'
			redirect_to auction_path(session[:auction_id]) and return
		else
			if @bid.amount
				if @existing_bids.length == 0
					if @bid.amount >= @auction.start_price
						@auction.current_bid = @auction.start_price
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
							@auction.save
							flash.notice = "You are now the high bidder, your maximum bid is #{Utilities.convert_to_price(@bid.amount)}"
						elsif @bid.amount <= @highest_bid.amount && @bid.amount > @auction.current_bid
							# The bid should increase by the challenging bidder plus the increment
							if @highest_bid.amount - @bid.amount < INCREMENT # Do not want to push the high bid over by less than the INCREMENT
								@auction.current_bid = @highest_bid.amount
							else
								@auction.current_bid = @bid.amount + INCREMENT
							end
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
				redirect_to auction_path(session[:auction_id])
			else
				flash.notice = 'Bid not entered, please try again'
				render :new
			end
		end
	end

	private
	
	def bid_params
		params.require(:bid).permit(:amount)
	end

end
