class DashboardController < ApplicationController
  def index
    @accountant = Accountant.new
    @unpaid_invoices = Invoice.unpaid
  end
end
