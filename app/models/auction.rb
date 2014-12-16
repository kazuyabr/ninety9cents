class Auction < ActiveRecord::Base
	has_many :bids
	has_many :question_answers
	has_many :bid_histories
	belongs_to :user
	validates :title, :category, :condition, :description, :start_price, :duration, :presence => true, :on => :create

	CATEGORIES = ['Antiques',
								'Alcohol',
								'Art',
								'Beauty',
								'Books and Magazines',
								'Business',
								'Cameras',
								'Cars, Bikes and Boats',
								'Collectibles',
								'Clothing and Shoes',
								'Computers',
								'Craft',
								'Electronics',
								'Food',
								'Glassware',
								'Health',
								'Home Appliances',
								'Industrial',
								'Jewellery',
								'Movies and Music',
								'Phones',
								'Pottery',
								'Sports',
								'Stamps',
								'Tickets',
								'Toys and Hobbies',
								'Video Games and Gaming Consoles',
								'Vehicle Parts and Accessories'
								]

	CONDITIONS = ['Brand new in box',
							  'New',
							  'Excellent used condition',
							  'Good used condition',
							  'Average condition',
							  'Poor condition - does not work'
							 	]

	DURATIONS = ['1 Day',
							 '2 Days',
							 '3 Days',
				  		 '4 Days',
				  		 '5 Days',
				  		 '6 Days',
				  		 '7 Days',
				  		 '8 Days',
				  		 '9 Days',
				  		 '10 Days',
				  		 '11 Days',
				  		 '12 Days',
				  		 '13 Days',
				  		 '14 Days'
				 			 ]				 	
end
