class ConversionRate < ActiveRecord::Base
  belongs_to :currency

  validates :valid_from, presence: true
  validates :valid_to, presence:true
  validates :rate, presence:true
  validates :valid_from, :valid_to, :overlap => { scope: :currency_id }
  validate :valid_to_is_after_valid_from

  def valid_to_is_after_valid_from
    return unless valid_from.present? && valid_to.present?
    errors.add(:valid_from, "Valid To needs to be after Valid From") if valid_to < valid_from
  end
end
