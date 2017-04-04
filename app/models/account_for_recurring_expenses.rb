class AccountForRecurringExpenses
  def call
    RecurringExpense.all.each { |recurring_expense| AccountForRecurringExpense.new(recurring_expense).call }
  end

  class AccountForRecurringExpense
    def initialize(recurring_expense)
     @recurring_expense = recurring_expense
    end

    def call
      occurrences_not_accounted_for_yet.each do |datetime|
        @recurring_expense.expenses.create!(description: @recurring_expense.description,
                                            value: @recurring_expense.value,
                                            currency: @recurring_expense.currency,
                                            includes_gst: @recurring_expense.includes_gst,
                                            date: datetime)
      end
    end

    def last_accounted_for
      @recurring_expense.expenses.order(date: :asc).last.try(:date)
    end

    def occurrences_not_accounted_for_yet
      from = last_accounted_for.present? ? last_accounted_for + 1.second : @recurring_expense.created_at
      @recurring_expense.schedule.occurrences_between(from, Time.now)
    end
  end
end
