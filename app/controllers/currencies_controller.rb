class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.includes(:conversion_rates)
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)

    if @currency.save
      flash.notice = "Currency saved successfully."
      redirect_to currencies_path
    else
      flash.alert = @currency.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @currency = Currency.find(params[:id])
  end

  def update
    @currency = Currency.find(params[:id])

    if @currency.update_attributes(currency_params)
      flash.notice = "Currency updated successfully."
      redirect_to currencies_path
    else
      flash.alert = @currency.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @currency = Currency.find(params[:id])

    if @currency.destroy
      flash.notice = "Currency was deleted successfully."
    else
      flash.notice = "Something went wrong."
    end

    redirect_to currencies_path
  end

  private
  def currency_params
    params.require(:currency).permit(:name, :code, :symbol)
  end
end
