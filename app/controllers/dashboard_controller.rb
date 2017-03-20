class DashboardController < ApplicationController
  def index
    @year_offset = (params[:year_offset] || 0).to_i
    @accountant = Accountant.new(Time.now + @year_offset.years)

    @unpaid_invoices = Invoice.unpaid.where(date: @accountant.fiscal_year).order(date: :desc)
    @voided_invoices = Invoice.voided.where(date: @accountant.fiscal_year).order(date: :desc)
    @paid_invoices = Invoice.paid.where(date: @accountant.fiscal_year).order(date: :desc)
    @expenses = Expense.where(date: @accountant.fiscal_year).order(date: :desc)
  end
end
