class AddUserIdToAmounts < ActiveRecord::Migration
  def change
    add_column :amounts, :user_id, :integer
  end
end
