class CreatePurchaseOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_orders do |t|
      t.string :client_name, null: false
      t.decimal :amount, precision: 10, scale: 2, default: 0.0, null: false
      t.decimal :tax, precision: 10, scale: 2
      t.string :vendor, null: false
      t.integer :status, null: false
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
