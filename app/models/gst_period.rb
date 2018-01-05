class GstPeriod
  attr_reader :from, :to

  def self.all
    start = Rails.application.secrets.gst_start.to_time
    period = Rails.application.secrets.gst_period_in_months.months

    froms = [start]
    while froms.last + period < Date.today
      froms << froms.last + period
    end

    froms.map do |from|
      to = (from + period - 1.day).end_of_day
      GstPeriod.new(from, to)
    end.reverse
  end

  def initialize(from, to)
    @from = from
    @to = to
  end

  def total_income
    Invoice.paid.where(date: from..to).inject(0) { |acc, invoice| acc + invoice.total_in_nzd }.to_f
  end

  def total_zero_rated_income
    Invoice.paid.where(date: from..to, zero_rated_gst: true).inject(0) { |acc, invoice| acc + invoice.total_in_nzd }.to_f
  end

  def expenses_with_gst
    Expense.where(date: from..to, includes_gst: true).inject(0) { |acc, expense| acc + expense.value_in_nzd }.to_f + gst_offsets_expenses
  end

  def gst_offsets_expenses
    GstOffset.where(date: from..to).map(&:amount).sum * 23.0 / 3.0
  end
end
