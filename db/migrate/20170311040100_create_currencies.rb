class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name, null:false
      t.string :code, null:false
      t.string :symbol, null:false

      t.timestamps
    end
  end
end
