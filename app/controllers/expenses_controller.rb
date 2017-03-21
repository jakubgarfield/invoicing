class ExpensesController < ApplicationController
  def new
    @currencies = Currency.all
    @expense = Expense.new(currency: @currencies.first, date: Date.today)
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      flash.notice = "Expense saved successfully."
      redirect_to root_path
    else
      @currencies = Currency.all
      flash.alert = @expense.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @currencies = Currency.all
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])

    if @expense.update_attributes(expense_params)
      flash.notice = "Expense updated successfully."
      redirect_to root_path
    else
      @currencies = Currency.all
      flash.alert = @expense.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if Expense.find(params[:id]).destroy
      flash.notice = "Expense was deleted successfully."
    else
      flash.alert = "Something went wrong while deleting the expense."
    end

    redirect_to root_path
  end

  private
  def expense_params
    params.require(:expense).permit(:description, :value, :date, :currency_id, :includes_gst)
  end
end
