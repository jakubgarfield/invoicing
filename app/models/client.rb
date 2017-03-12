class Client < ActiveRecord::Base
  has_many :invoices

  validates :name, presence: true
  validates :address_line_1, presence: true
end
