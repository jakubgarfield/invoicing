class InvoicesController < ApplicationController
  def new
    setup_form_data
    last_invoice = Invoice.includes(contact: :client).last
    @invoice = Invoice.new(currency: Currency.find_by(code: 'NZD'),
                           date: Date.today,
                           contact: last_invoice.contact,
                           zero_rated_gst: last_invoice.zero_rated_gst?,
                           status: :unpaid,
                           number: @numbers[last_invoice.contact.client.group])
    @invoice.line_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)
    params[:invoice][:line_items].each do |line_item_params|
      @invoice.line_items.build(line_item_params.permit(:description, :quantity, :unit_price))
    end

    if @invoice.save
      flash.notice = "Invoice saved successfully."
      redirect_to root_path
    else
      setup_form_data
      @invoice.line_items.build if @invoice.line_items.empty?
      flash.alert = @invoice.errors.full_messages.concat(@invoice.line_items.flat_map { |li| li.errors.full_messages }).to_sentence
      render :new
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
      format.pdf do
        html = render_to_string(template: 'invoices/show.html.erb', layout: false)
        send_data(PDFKit.new(html).to_pdf, type: 'application/pdf', filename: @invoice.filename)
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

  private
  def setup_form_data
    @contacts = Contact.joins(:client).includes(:client).order('clients.group asc, UPPER(clients.company) asc, contacts.name asc')
    @currencies = Currency.order(:code)
    @numbers = Invoice.joins(contact: :client).group('clients.group').maximum('number + 1')
  end

  def invoice_params
    params.require(:invoice).permit(:contact_id, :currency_id, :date, :zero_rated_gst, :number, :discount_in_percent, :status)
  end
end
