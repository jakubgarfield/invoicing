class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :company
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :address_line_3
      t.string :address_line_4
      t.string :group

      t.timestamps
    end
  end
end
