class AddAmountRefundedToAmounts < ActiveRecord::Migration
  def change
    add_column :amounts, :amount_refunded, :integer 
  end
end
