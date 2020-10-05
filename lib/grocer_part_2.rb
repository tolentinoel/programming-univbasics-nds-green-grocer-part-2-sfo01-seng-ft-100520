require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  i = 0
  coupons.each do |coupon|
    discounted = find_item_by_name_in_collection(coupon[:item], cart)
    in_cart = !!discounted
    okay_num = in_cart && discounted[:count] >= coupon[:num]
    
    if discounted && okay_num
      cart << { item: "#{discounted[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: discounted[:clearance],
                count: coupon[:num]
              }
      discounted[:count] -= coupon[:num]
    end
    i += 1
  end
  cart
end

  
def apply_clearance(cart)
  cart.each do |i|
    if i[:clearance] == true
      i[:price] *= 0.8
    
    end
    i
  end
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated = consolidate_cart(cart)
  final_cart = apply_coupons(consolidated, coupons)
  apply_clearance(final_cart)
  
  to_pay = 0 
  
  final_cart.each do |item|
    to_pay += item[:price] * item[:count]
  end
end
