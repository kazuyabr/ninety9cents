class WatchersController < ApplicationController

	def new
		@watcher = Watcher.new
		@watcher.auction_id = session[:auction_id]
		@watcher.user_id = @current_user.id

		if @watcher.save
			redirect_to auction_path(session[:auction_id]), :notice => 'You are now watching this auction'
		else
			flash.notice = 'Watch failed, please try again'
			render :new
		end
	end

	def destroy
		@watcher = Watcher.where(:auction_id => session[:auction_id]).where(:user_id => @current_user)
		@watcher.first.destroy
		redirect_to auction_path(session[:auction_id]), :notice => 'You are no longer watching this auction'
	end

end