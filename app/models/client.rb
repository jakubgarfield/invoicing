class Client < ActiveRecord::Base
  has_many :contacts, dependent: :destroy
  has_many :invoices, through: :contacts

  validates :contacts, presence: true
  validates :address_line_1, presence: true
end
