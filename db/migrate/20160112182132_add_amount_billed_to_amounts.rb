class AddAmountBilledToAmounts < ActiveRecord::Migration
  def change
    add_column :amounts, :amount_billed, :integer 
  end
end
