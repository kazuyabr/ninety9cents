class CreateBidHistories < ActiveRecord::Migration
  def change
    create_table :bid_histories do |t|
      t.integer :amount
      t.datetime :bid_time
      t.string :username
      t.integer :auction_id

      t.timestamps
    end
  end
end
