class CombineItemsInCart < ActiveRecord::Migration[5.1]
  	
  	#replace multiple items for a single product in a cart
  	# with a single item

	def up 
		Cart.all.each do |cart|
			sums = cart.line_items.group(:product_id).sum(:quantity)
			sums.each do |product, quantity|
				if quantity > 1
					cart.line_items.where(product_id: product).delete_all
					item = cart.line_items.build(product_id: product)
					item.quantity = quantity
					item.save!
				end
			end
		end
	end

	def down
		LineItem.where("quantity>1").each do |line_item|
			line_item.quantity.times do 
				LineItem.create(
					product_id: line_item.product_id,
					cart_id: line_item.cart_id,
					quantity: 1
				)
			end
			line_item.destroy
		end
	end

end
