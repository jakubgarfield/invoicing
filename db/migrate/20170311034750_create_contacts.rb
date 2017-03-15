class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :client, index: true, foreign_key: true, null: false
      t.string :name, null:false
      t.string :email, null:false
      t.string :position
      t.timestamps
    end
  end
end
