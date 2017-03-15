class Currency < ActiveRecord::Base
  has_many :conversion_rates
  has_many :expenses
  has_many :invoices

  validates :code, presence: true
  validates :name, presence: true
  validates :symbol, presence: true

  def conversion_rate(date)
    available_conversion_rates = conversion_rates.where("valid_from < :date AND valid_to >= :date", date: date)
    raise "Conversion rate for #{date} is missing" if available_conversion_rates.empty?
    available_conversion_rates.first
  end
end
