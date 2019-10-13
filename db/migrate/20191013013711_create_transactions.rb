class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :payment_method
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :submit_date
      t.string :status

      t.timestamps
    end
  end
end
