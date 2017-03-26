class ConversionRatesController < ApplicationController
  def new
    @currency = Currency.find(params[:currency_id])
    @conversion_rate = @currency.conversion_rates.build
  end

  def create
    @currency = Currency.find(params[:currency_id])
    @conversion_rate = @currency.conversion_rates.build(conversion_rate_params)

    if @conversion_rate.save
      flash.notice = "Conversion rate saved successfully."
      redirect_to currencies_path
    else
      flash.alert = @conversion_rate.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @currency = Currency.find(params[:currency_id])
    @conversion_rate = @currency.conversion_rates.find(params[:id])
  end

  def update
    @currency = Currency.find(params[:currency_id])
    @conversion_rate = @currency.conversion_rates.find(params[:id])

    if @conversion_rate.update_attributes(conversion_rate_params)
      flash.notice = "Conversion rate updated successfully."
      redirect_to currencies_path
    else
      flash.alert = @conversion_rate.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @currency = Currency.find(params[:currency_id])
    @conversion_rate = @currency.conversion_rates.find(params[:id])

    if @conversion_rate.destroy
      flash.notice = "Conversion rate was deleted successfully."
    else
      flash.notice = "Something went wrong."
    end

    redirect_to currencies_path
  end

  private
  def conversion_rate_params
    params.require(:conversion_rate).permit(:valid_from, :valid_to, :rate)
  end
end
