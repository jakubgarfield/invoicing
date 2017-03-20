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
  end

  def pay
  end
end
