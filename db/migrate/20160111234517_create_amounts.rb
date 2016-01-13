class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.integer :charge_amt
      t.timestamps null: false
    end
  end
end
