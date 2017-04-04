class RecurringExpensesController < ApplicationController
  def new
    @currencies = Currency.order(:code)
    @recurring_expense = RecurringExpense.new
  end

  def create
    @recurring_expense = RecurringExpense.new(recurring_expense_params)

    if @recurring_expense.save
      flash.notice = "Recurring expense saved successfully."
      redirect_to expenses_path
    else
      @currencies = Currency.order(:code)
      flash.alert = @recurring_expense.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @currencies = Currency.order(:code)
    @recurring_expense = RecurringExpense.find(params[:id])
  end

  def update
    @recurring_expense = RecurringExpense.find(params[:id])

    if @recurring_expense.update_attributes(recurring_expense_params)
      flash.notice = "Recurring expense updated successfully."
      redirect_to expenses_path
    else
      @currencies = Currency.order(:code)
      flash.alert = @recurring_expense.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if RecurringExpense.find(params[:id]).destroy
      flash.notice = "Recurring expense was deleted successfully."
    else
      flash.alert = "Something went wrong while deleting the recurring expense."
    end

    redirect_to expenses_path
  end

  private
  def recurring_expense_params
    params.require(:recurring_expense).permit(:name, :description, :value, :currency_id, :includes_gst, schedule_attributes: Schedulable::ScheduleSupport.param_names)
  end
end
