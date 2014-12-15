class UsersController < ApplicationController
	skip_before_action :authenticate, :only => [:new, :create]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		# Change this to use user_params (don't forget to add the password info in the user_params def below)
		@user = User.new
		@user.first_name = params[:first_name]
		@user.last_name = params[:last_name]
		@user.email = params[:email]
		@user.username = params[:username]
		@user.password = params[:password]
		@user.password_confirmation = params[:password_confirmation]

		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, :notice => 'New account created successfully'
		else
			flash.notice = 'Account not created, please try again'
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		current_user.update(user_params)
		redirect_to user_path :notice => 'Details updated successfully'
	end

	def pass
	end

	def password
		@current_user.password = params[:new_password]
		@current_user.password_confirmation = params[:password_confirmation]
		@current_user.save
		redirect_to user_path(@current_user.id), :notice => 'Password updated successfully'
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path :notice => 'Your account has been deleted successfully'
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :username)
	end
end