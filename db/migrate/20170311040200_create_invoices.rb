class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :contact, index: true, foreign_key: true, null: false
      t.belongs_to :currency, index: true, foreign_key: true, null: false
      t.date :date, null: false
      t.boolean :zero_rated_gst, null: false
      t.integer :number, null: false, unique: true
      t.integer :discount_in_percents, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
