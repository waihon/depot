class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, quantity)
    # LESSON: With declaration of "has_many :line_items", line_items below belong to current cart
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      #current_item.quantity += 1
      current_item.quantity += quantity
    else
      # LESSON: line_items belong to current cart, by providing product_id to "build", both
      # foreign keys (cart_id and product_id) are available.
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    # LESSON: Using to_a.sum add up a numeric attribute or method of a model
    line_items.to_a.sum { |item| item.total_price }
  end
end
