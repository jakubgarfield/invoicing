class Expense < ActiveRecord::Base
  belongs_to :currency

  validates :currency, presence: true
  validates :description, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :includes_gst, inclusion: { in: [ true, false ] }
  validates :date, presence:true
  validate :is_low_cost_asset

  def claimable_value
    value_in_nzd - gst
  end

  def gst
    if includes_gst?
      value_in_nzd / 23 * 3
    else
      0
    end
  end

  def value_in_nzd
    @value_in_nzd ||= value * currency.conversion_rate(date).rate
  end

  private
  def is_low_cost_asset
    errors.add(:value, 'higher than 500 NZD needs to be depreciated') if value_in_nzd > 500
  end
end
