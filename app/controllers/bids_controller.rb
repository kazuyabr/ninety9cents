class BidsController < ApplicationController

	INCREMENT = 100

	def new
		@bid = Bid.new
	end

	def create
		# Set up the new bid
		@bid = Bid.new(bid_params)
		@bid.bid_time = Time.now
		@bid.user_id = @current_user.id
		@bid.auction_id = session[:auction_id]

		# Fetch the auction and its associated bids
		@auction = Auction.find(session[:auction_id])
		@existing_bids = Bid.where(:auction_id => session[:auction_id])
		
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
				@highest_bid = get_highest_bid(@existing_bids)
				if @bid.amount > @highest_bid.amount # There is a new high bidder
					@auction.current_bid = @highest_bid.amount + INCREMENT
					@auction.save
					flash.notice = 'You are now the high bidder'
				elsif @bid.amount < @highest_bid.amount && @bid.amount > @auction.current_bid
					# The bid should increase by the challenging bidder plus the increment
					if @highest_bid.amount - @bid.amount < INCREMENT # Do not want to push the high bid over by less than INCREMENT
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

	private
	
	def bid_params
		params.require(:bid).permit(:amount)
	end

	def get_highest_bid(bids)
		highest_bid = bids[0]
		bids.each do |bid|
			if bid.amount > highest_bid.amount
				highest_bid = bid
			end
		end
		return highest_bid
	end

end
