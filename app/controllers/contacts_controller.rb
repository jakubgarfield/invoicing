class ContactsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.build
  end

  def create
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.build(contact_params)

    if @contact.save
      flash.notice = "Contact saved successfully."
      redirect_to clients_path
    else
      flash.alert = @contact.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.find(params[:id])
  end

  def update
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.find(params[:id])

    if @contact.update_attributes(contact_params)
      flash.notice = "Contact updated successfully."
      redirect_to clients_path
    else
      flash.alert = @contact.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:client_id])
    @contact = @client.contacts.find(params[:id])

    if @contact.client.contacts.size == 1
      flash.alert = "Create a new contact first before deleting the last one."
    elsif @contact.invoices.exists?
      flash.alert = "Can't delete a contact that was already invoiced."
    elsif @contact.destroy
      flash.notice = "Contact was deleted successfully."
    else
      flash.notice = "Something went wrong."
    end

    redirect_to clients_path
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :position, :email)
  end
end
