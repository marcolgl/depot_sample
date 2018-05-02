class StoreController < ApplicationController
before_action :init_counter, only: [:index]
after_action :inc_counter, only: [:index]
include CurrentCart
before_action :set_cart

  def init_counter 
  	if session[:counter].nil?
  		session[:counter] = 0
  	end
 end

 def inc_counter
 	session[:counter]= session[:counter]+1
 end

  def index
  	@products = Product.order(:title)
  end
end
