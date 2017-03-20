class InvoicesController < ApplicationController
  def create
  end

  def new
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
      format.pdf do
        send_data(PDFKit.new(invoice_url(@invoice)).to_pdf, type: 'application/pdf', filename: @invoice.filename)
      end
    end
  end

  def void
    @invoice = Invoice.find(params[:id])

    if @invoice.update_attributes(status: :voided)
      flash.notice = "Invoice was successfully voided."
    else
      flash.alert = "Something was wrong while voiding the invoice."
    end

    redirect_to root_path
  end

  def pay
    @invoice = Invoice.find(params[:id])

    if @invoice.update_attributes(status: :paid)
      flash.notice = "Invoice was successfully paid."
    else
      flash.alert = "Something was wrong while paying the invoice."
    end

    redirect_to root_path
  end
end
