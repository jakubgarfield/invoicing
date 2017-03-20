class DashboardController < ApplicationController
  def index
    @accountant = Accountant.new
    @unpaid_invoices = Invoice.unpaid

    @paid_invoices = Invoice.paid.where(date: @accountant.fiscal_year).order(date: :desc)
    @expenses = Expense.where(date: @accountant.fiscal_year).order(date: :desc)
  end
end
