class InvoicesController < ApplicationController
  def create
  end

  def new
  end

  def show
    @invoice = Invoice.find(params[:id])
    render layout: false
  end

  def void
  end

  def pay
  end
end
