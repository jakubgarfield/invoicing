class CreateGstOffsets < ActiveRecord::Migration
  def change
    create_table :gst_offsets do |t|
      t.decimal :amount
      t.datetime :date
      t.string :note
      t.timestamps
    end
  end
end
