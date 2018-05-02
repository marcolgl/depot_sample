class Order < ApplicationRecord
	has_many :line_items, dependent: :destroy
	enum pay_type: {
		"Check"	 		 => 0,
		"Credit card"	 => 1,
		"Purchase order" => 2
	}
	load "concerns/email_valid.rb"
	validates :name, :address, :email, presence: true, length: { maximum: 40 }
	validates :pay_type, inclusion: pay_types.keys
	validates :email, uniqueness: true, email: true


	#add the items from the cart to the order
	def add_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end

end
