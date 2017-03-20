class DashboardController < ApplicationController
  def index
    @accountant = Accountant.new

    @unpaid_invoices = Invoice.unpaid.where(date: @accountant.fiscal_year).order(date: :desc)
    @voided_invoices = Invoice.voided.where(date: @accountant.fiscal_year).order(date: :desc)
    @paid_invoices = Invoice.paid.where(date: @accountant.fiscal_year).order(date: :desc)
    @expenses = Expense.where(date: @accountant.fiscal_year).order(date: :desc)
  end
end
