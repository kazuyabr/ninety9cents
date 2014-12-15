class AuctionsController < ApplicationController
	skip_before_action :authenticate, :only => [:index]

	def index
		@auctions = Auction.all
	end

	def show
		@auction = Auction.find(params[:id])
		session[:auction_id] = @auction.id
		@existing_bids = Bid.where(:auction_id => @auction.id)
		@highest_bid = Utilities.get_highest_bid(@existing_bids)
		if @highest_bid
			@user = User.find(@highest_bid.user_id)
		end
		@qas = QuestionsAnswer.where(:auction_id => @auction.id)
		@qa = QuestionsAnswer.new
	end

	def show_my
		@auctions = Auction.where(:user_id => @current_user.id)
	end

	def new
		@auction = Auction.new
	end

	AEDT = 39600 # Australian Eastern Daylight Time

	def create
		time = Time.now + AEDT
		@auction = Auction.new(auction_params)
		@auction.user_id = @current_user.id
		@auction.start_time = time
		days = auction_params[:duration].split(' ').first.to_i
		@auction.end_time = time + (86400 * days)

		# Convert to integers and handle input with or without cents
		@auction.start_price = (auction_params[:start_price].to_f * 100).to_i
		@auction.reserve = (auction_params[:reserve].to_f * 100).to_i

		if @auction.save
			redirect_to auction_path(@auction.id), :notice => 'New auction created successfully'
		else
			flash.notice = 'Auction not created, please try again'
			render :new
		end
	end

	def edit
		@auction = Auction.find(params[:id])
	end

	def update
		@auction = Auction.find(params[:id])
		@auction.update(auction_params)
		redirect_to auction_path, :notice => 'Auction updated successfully'
	end

	def destroy
		@auction = Auction.find(params[:id])
		@auction.destroy
		redirect_to root_path, :notice => 'Auction deleted successfully'
	end

	private
	
	def auction_params
		params.require(:auction).permit(:title, :category, :condition, :description, :start_price, :duration, :reserve, :primary_picture)
	end
		
end
