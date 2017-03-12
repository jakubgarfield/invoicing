class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null:false
      t.string :position
      t.string :company
      t.string :company_tax_id
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :address_line_3

      t.timestamps
    end
  end
end
