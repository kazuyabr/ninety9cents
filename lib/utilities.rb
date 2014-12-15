class Utilities

	def self.convert_to_price(number)
		number = number.to_f / 100
		# Ensure zeros appear to two decimal places
		if (number * 100) % 10 == 0
			result = "$" + number.to_s + "0"
		else
			result = "$" + number.to_s
		end

		# Add commas for thousands as needed
		result = result.reverse
		counter = 6
		while counter < result.length - 1
			result.insert(counter, ',')
			counter += 4
		end

		return result.reverse
	end

	def self.get_highest_bid(bids)
		highest_bid = bids[0]
		bids.each do |bid|
			if bid.amount > highest_bid.amount
				highest_bid = bid
			elsif bid.amount == highest_bid.amount # case where there are two high bids of the same amount - use the earlier one
				if bid.bid_time < highest_bid.bid_time
					highest_bid = bid
				end
			end
		end
		return highest_bid
	end

end