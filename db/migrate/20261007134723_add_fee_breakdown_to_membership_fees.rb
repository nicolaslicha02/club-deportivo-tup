class AddFeeBreakdownToMembershipFees < ActiveRecord::Migration[8.1]
  def change
    add_column :membership_fees, :fee_breakdown, :text
  end
end
