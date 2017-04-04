class AddRecurringExpenseToExpense < ActiveRecord::Migration
  def up
    add_reference :expenses, :recurring_expense, index: true, foreign_key: true
    change_column :expenses, :date, :datetime
  end

  def down
    remove_reference :expenses, :recurring_expense
    change_column :expenses, :date, :date
  end
end
