class Cart < ApplicationRecord
	
	has_many :line_items, dependent: :destroy


	# add a product in the cart
	def add_product(product)
		current_item = line_items.find_by(product_id: product.id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product.id)
		end
		current_item
	end



	def total_price
		sum = 0
		line_items.to_a.each do |item|
			sum += item.total_price
		end
		sum
	end

end
