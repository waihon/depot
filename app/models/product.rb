class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private

  # Ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    # LESSON: With declaration of "has_many :line_items", line_items below belong to current product
    if line_items.empty?
      return true
    else
      # Associate the error with the base object instead of individual attributes
      errors.add(:base, 'Line Items present') 
      return false
    end
  end

	#validates :title, allow_blank: true, length: { minimum: 10 }, message: 'should be 10 characters or more'
  validates_length_of :title, minimum: 10, allow_blank: true, message: 'should be 10 characters or more'
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :image_url, allow_blank: true,
	format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}

  def self.latest
    Product.order(:updated_at).last
  end
end
