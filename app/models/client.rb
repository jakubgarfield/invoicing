class Client < ActiveRecord::Base
  has_many :contacts
  has_many :invoices

  validates :contacts, presence: true
  validates :address_line_1, presence: true
end
