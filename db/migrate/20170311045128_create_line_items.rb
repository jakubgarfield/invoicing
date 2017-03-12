class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :invoice, index: true, foreign_key: true, null: false
      t.string :description, null: false
      t.integer :quantity, null: false
      t.decimal :unit_price, :precision => 8, :scale => 2, null: false

      t.timestamps
    end
  end
end
