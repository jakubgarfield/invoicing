class ClientsController < ApplicationController
  def index
    @clients = Client.includes(:contacts).order(:group, :company)
  end

  def new
    @groups = Client.distinct(:group).pluck(:group)
    @client = Client.new
    @contact = @client.contacts.build
  end

  def create
    @client = Client.new(client_params)
    @contact = @client.contacts.build(contact_params)

    if @client.save
      flash.notice = "Client saved successfully."
      redirect_to clients_path
    else
      @groups = Client.distinct(:group).pluck(:group)
      flash.alert = @client.errors.full_messages.concat(@contact.errors.full_messages).to_sentence
      render :new
    end
  end

  def edit
    @groups = Client.distinct(:group).pluck(:group)
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update_attributes(client_params)
      flash.notice = "Client updated successfully."
      redirect_to clients_path
    else
      @groups = Client.distinct(:group).pluck(:group)
      flash.alert = @client.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])

    if @client.invoices.exists?
      flash.alert = "Can't delete a client that was already invoiced."
    elsif @client.destroy
      flash.notice = "Client was deleted successfully."
    else
      flash.notice = "Something went wrong."
    end

    redirect_to clients_path
  end

  private
  def client_params
    params.require(:client).permit(:company, :group, :address_line_1, :address_line_2, :address_line_3, :address_line_4)
  end

  def contact_params
    params.require(:contact).permit(:name, :position, :email)
  end
end
