require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  # REMEMBER: This method **should** update cart
updated_cart = []
  cart.each do |cart_item|
    nil_checker = true
    coupons.each do |coupon_item|
      if cart_item[:item] == coupon_item[:item]
       
        # APPLY coupon if they have exact number
        if cart_item[:count] == coupon_item[:num]
          with_coupon_hash = {}
          
          with_coupon_hash[:item] = cart_item[:item] + ' W/COUPON'
          with_coupon_hash[:price] = (coupon_item[:cost]/cart_item[:count]).round(2)
          with_coupon_hash[:clearance] = cart_item[:clearance]
          with_coupon_hash[:count] = cart_item[:count]
        updated_cart.push(with_coupon_hash)
        cart_item[:count] -= coupon_item[:num]
        updated_cart.push(cart_item)
        nil_checker = false
      end
      ### APPLY coupon if they have extra items
     
      if cart_item[:count] > coupon_item[:num]
        
        coupon_multiplier = (cart_item[:count] / coupon_item[:num]).floor
        extra_items = cart_item[:count] % coupon_item[:num]
        
          ### Push W/ Coupon Item 
          with_coupon_hash = {}
          with_coupon_hash[:item] = cart_item[:item] + " W/COUPON"
          with_coupon_hash[:price] = (coupon_item[:cost]/coupon_item[:num]).round(2)
          with_coupon_hash[:clearance] = cart_item[:clearance]
          with_coupon_hash[:count] = coupon_multiplier * coupon_item[:num]
          updated_cart.push(with_coupon_hash)
          cart_item[:count] -= coupon_item[:num]
          nil_checker = false
          
          if extra_items != 0 
            cart_item[:count] = extra_items
            updated_cart.push(cart_item)
            nil_checker = false
          end
          
        end
      end
    end
    if nil_checker == true
      updated_cart.push(cart_item)
    end
  end
  cart = updated_cart
  cart
end
        

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    if cart_item[:clearance] == true
      (cart_item[:price] *= 0.80).round(2)
    end
  end
end

def checkout(cart, coupons)
  
 clean_cart = consolidate_cart(cart)
 couponed_cart = apply_coupons(clean_cart, coupons)
 clearanced_cart = apply_clearance(couponed_cart)
 
 total = 0
 clearanced_cart.each do |cart_item|
   total += (cart_item[:count] * cart_item[:price])
 end

 if total > 100
   total *= 0.90
 end
 
 total.round(2)
end
