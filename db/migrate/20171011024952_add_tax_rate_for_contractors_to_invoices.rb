class AddTaxRateForContractorsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :tax_rate_for_contractors, :bool, null: false, default: false
  end
end
