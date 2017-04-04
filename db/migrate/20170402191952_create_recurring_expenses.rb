class CreateRecurringExpenses < ActiveRecord::Migration
  def change
    create_table :recurring_expenses do |t|
      t.belongs_to :currency, index: true, foreign_key: true, null: false
      t.decimal :value, :precision => 8, :scale => 2, null: false
      t.boolean :includes_gst, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
