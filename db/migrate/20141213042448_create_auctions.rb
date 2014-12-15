class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :category
      t.integer :number
      t.string :title
      t.string :condition
      t.text :description
      t.integer :start_price
      t.integer :current_bid
      t.datetime :start_time
      t.datetime :end_time
      t.integer :buy_now_price
      t.integer :reserve
      t.string :primary_picture
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
