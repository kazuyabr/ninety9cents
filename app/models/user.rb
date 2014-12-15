class User < ActiveRecord::Base
	has_many :auctions
	has_many :bids
	has_secure_password
	validates :username, :uniqueness => true
	validates :first_name, :last_name, :email, :username, :password_confirmation, :presence => true, :on => :create
end
