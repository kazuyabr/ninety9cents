class AddAuctionIdToQuestionsAnswers < ActiveRecord::Migration
  def change
    add_column :questions_answers, :auction_id, :integer
  end
end
