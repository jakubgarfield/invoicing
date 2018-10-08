class Accountant
  def initialize(date = Time.now)
    @date = date
  end

  def fiscal_year
    if @date.month < 4
      Time.new(@date.year - 1, 4, 1).beginning_of_day..Time.new(@date.year, 3, 31).end_of_day
    else
      Time.new(@date.year, 4, 1).beginning_of_day..Time.new(@date.year + 1, 3, 31).end_of_day
    end
  end

  def taxes
    tax_base_income = gross_income - claimable_expenses
    tax = 0

    tax += tax_component(tax_base_income, 0, 14000, 0.105.to_d)
    tax += tax_component(tax_base_income, 14000, 48000, 0.175.to_d)
    tax += tax_component(tax_base_income, 48000, 70000, 0.3.to_d)
    tax += tax_component(tax_base_income, 70000, Float::MAX, 0.33.to_d)

    tax
  end

  def acc
    maximum_earnings = 122063
    maximum_levy = 1697.67.to_d
    levy_rate = 0.0139

    if gross_income > maximum_earnings
      maximum_levy
    else
      gross_income * levy_rate
    end
  end

  def gst
    @gst ||= paid_invoices.inject(0) { |sum, invoice| sum + invoice.gst } - claimable_gst
  end

  def income
    gross_income - taxes - acc
  end

  def revenue
    income - claimable_expenses
  end

  def gross_income
    @gross_income ||= paid_invoices.inject(0) { |sum, invoice| sum + (invoice.total_in_nzd - invoice.gst) }
  end

  def taxes_paid
    @taxes_paid ||= paid_invoices.inject(0) { |sum, invoice| sum + invoice.tax_paid }
  end

  def claimable_expenses
    @claimable_expenses ||= paid_expenses.map(&:claimable_value).sum
  end

  def claimable_gst
    # GST offsets are used for assets that are depreciated
    @claimable_gst ||= paid_expenses.map(&:gst).sum + gst_offsets.map(&:amount).sum
  end

  private
  def paid_invoices
    @paid_invoices ||= Invoice.includes(:line_items, :currency).where(date: fiscal_year).paid
  end

  def paid_expenses
    @paid_expenses ||= Expense.includes(:currency).where(date: fiscal_year)
  end

  def gst_offsets
    @gst_offsets ||= GstOffset.where(date: fiscal_year)
  end

  def tax_component(income, from, to, at)
    if income > from
      ([to, income].min - from) * at
    else
      0
    end
  end
end
