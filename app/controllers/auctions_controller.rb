class AuctionsController < ApplicationController
	skip_before_action :authenticate, :only => [:index]

	def index
		@auctions = Auction.where(:status => 'live')
	end

	# This method is currently not being used
	def show_ended
		@auctions = Auction.where(:status => 'ended')
	end

	def show
		@auction = Auction.find(params[:id])
		session[:auction_id] = @auction.id
		@existing_bids = Bid.where(:auction_id => @auction.id)

		@current_user_bid = false
		@existing_bids.each do |bid|
			if bid.user_id == @current_user.id
				@current_user_bid = true
			end
		end

		@highest_bid = Utilities.get_highest_bid(@existing_bids)
		if @highest_bid
			@user = User.find(@highest_bid.user_id)
		end
		
		@watcher = Watcher.where(:auction_id => @auction.id).where(:user_id => @current_user)
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
		days = auction_params[:duration].split(' ').first.to_i

		# Convert to integers and handle input with or without cents
		@auction.start_price = (auction_params[:start_price].to_f * 100).to_i
		@auction.reserve = (auction_params[:reserve].to_f * 100).to_i

		if @auction.start_time < time
			@auction.status = 'live'
			@auction.start_time = time
			@auction.end_time = time + (86400 * days)
		else
			@auction.status = 'scheduled'
			@auction.end_time = @auction.start_time + (86400 * days)
			# Schedule the auction to start after the specified duration has elapsed
			scheduler = Rufus::Scheduler.new
			# For production the next line should be scheduler.at @auction.start_time do
			# This has not yet been impelmented due to the demo to be performed Friday 20/12/14
			scheduler.in '30s' do
				puts ""
				puts "Auction started.................................................."
				puts ""
			  @auction.status = 'live'
			  @auction.save
			end
		end

		# Schedule the auction to end after the specified duration has elapsed
		scheduler = Rufus::Scheduler.new
		# For production the next line should be scheduler.at @auction.end_time do
		# This has not yet been impelmented due to the demo to be performed Friday 20/12/14
		scheduler.in '60s' do
			puts ""
			puts "Auction ended.................................................."
			puts ""
		  @auction.status = 'ended'
		  @auction.save
		end

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
		if @auction.status == 'scheduled'
			@auction.destroy
			redirect_to root_path, :notice => 'Auction deleted successfully'
		else
			redirect_to root_path, :notice => 'Sorry this auction can no longer be deleted'
		end
	end

	private
	
	def auction_params
		params.require(:auction).permit(:title, :category, :condition, :description, :start_price, :start_time, :duration, :reserve, :primary_picture)
	end
		
end
