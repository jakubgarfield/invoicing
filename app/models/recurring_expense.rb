class RecurringExpense < ActiveRecord::Base
  acts_as_schedulable :schedule

  belongs_to :currency
  has_many :expenses, dependent: :nullify

  validates :currency, presence: true
  validates :description, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :includes_gst, inclusion: { in: [ true, false ] }
end
