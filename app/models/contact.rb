class Contact < ActiveRecord::Base
  belongs_to :client

  validates :client, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
