class BidHistorysController < ApplicationController

	def show
		@bids = BidHistory.where(:auction_id => session[:auction_id])
	end

end