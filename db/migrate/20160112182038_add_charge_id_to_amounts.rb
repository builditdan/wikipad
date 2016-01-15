class AddChargeIdToAmounts < ActiveRecord::Migration
  def change
    add_column :amounts, :charge_id, :string
  end
end
