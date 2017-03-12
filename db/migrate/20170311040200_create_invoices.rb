class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :client, index: true, foreign_key: true, null: false
      t.belongs_to :currency, index: true, foreign_key: true, null: false
      t.date :date, null: false
      t.boolean :zero_rated_gst, null: false
      t.integer :number, null: false, unique: true
      t.integer :discount_in_percents
      t.integer :status, :integer, default: 0, null: false
    end
  end
end
