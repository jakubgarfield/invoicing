class LineItem < ActiveRecord::Base
  belongs_to :invoice

  validates :invoice, presence: true
  validates :description, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }

  def total
    quantity * unit_price
  end
end
