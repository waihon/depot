class StoreController < ApplicationController
  def index
    @products = Product.order(:title)   # Sort by Title in alphabetically order
  end
end
