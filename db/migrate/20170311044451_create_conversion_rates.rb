class CreateConversionRates < ActiveRecord::Migration
  def change
    create_table :conversion_rates do |t|
      t.belongs_to :currency, index: true, foreign_key: true, null: false
      t.date :valid_from, null: false
      t.date :valid_to, null: false
      t.decimal :rate, :precision => 6, :scale => 4, null: false

      t.timestamps
    end
  end
end
