class QuestionsAnswersController < ApplicationController

	def new
		@qa = QuestionsAnswer.new
	end

	def create
		@qa = QuestionsAnswer.new
		@qa.question = params[:questions_answer][:question]
		@qa.auction_id = params[:questions_answer][:auction_id]
	
		if @qa.save
			redirect_to auction_path(params[:questions_answer][:auction_id]), :notice => 'Question created successfully'
		else
			flash.notice = 'Question not saved, please try again'
			render :new
		end
	end

end