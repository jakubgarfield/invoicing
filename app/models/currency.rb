class Currency < ActiveRecord::Base
  has_many :conversion_rates
  has_many :expenses
  has_many :invoices

  validates :code, presence: true
  validates :name, presence: true
  validates :symbol, presence: true

  def conversion_rate(date)
    # TODO: Improve caching of conversion rates for dashboard (renders in 701 ms)
    available_conversion_rate = conversion_rates.where("DATE_TRUNC('day', valid_from) < :date AND DATE_TRUNC('day', valid_to) + interval '1 day' - interval '1 second' >= :date", date: date).first
    raise "Conversion rate for #{date} is missing" if available_conversion_rate.nil?
    available_conversion_rate
  end
end
