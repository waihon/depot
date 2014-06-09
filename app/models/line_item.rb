class LineItem < ActiveRecord::Base
  belongs_to :product # LineItem references Product => Product has many Line Items
  belongs_to :cart    # Cart has many Line Items

  def total_price
    product.price * quantity
  end
end
