class PagesController < ApplicationController
	skip_before_action :authenticate
	
	def index
		# This will select al auctions regardless of status, will need to pick out those that are live
		# This has not yet been impelmented due to the demo to be performed Friday 20/12/14
		@auctions = Auction.limit(10)
	end

	def about
	end

end
