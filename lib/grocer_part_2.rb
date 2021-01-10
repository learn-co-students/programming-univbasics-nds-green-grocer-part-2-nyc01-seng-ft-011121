require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  receipt = []
  if coupons == []
    return cart
  end
  cart.each do |product|
    coupons.each do |discounted|
      if product[:item] == discounted[:item]
        qty = product[:count]
        remain = product[:count] % discounted[:num]

        product[:count] = remain
        couponItemHash = {:item => product[:item] + ' W/COUPON',
                         :price => discounted[:cost] / discounted[:num],
                         :clearance => product[:clearance],
                         :count => qty - remain}
        receipt << couponItemHash
      end
    end
    receipt << product
  end
  return receipt
end



  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def apply_clearance(cart)
  cart.each do |product|
    product[:price] = product[:price] * 0.80 if product[:clearance]
  end
end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart


def checkout(cart, coupons)
  total = 0
  conCart = consolidate_cart(cart)
  coupCart = apply_coupons(conCart, coupons)
  apply_clearance(coupCart)
  coupCart.each do |product|
    total += product[:price] * product[:count]
  end
  if total > 100
    total = total * 0.90
  end
  return total.round(2)
end


  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
