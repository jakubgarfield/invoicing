class DashboardController < ApplicationController
  def index
    @accountant = Accountant.new
    @unpaid_invoices = Invoice.unpaid

    @invoices = Invoice.where(date: @accountant.fiscal_year).order(:date)
    @expenses = Expense.where(date: @accountant.fiscal_year).order(:date)
  end
end
