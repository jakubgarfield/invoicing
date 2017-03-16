class Contact < ActiveRecord::Base
  belongs_to :client
  has_many :invoices

  validates :client, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
