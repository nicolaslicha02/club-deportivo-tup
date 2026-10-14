class AddReviewDetailsToMembershipFees < ActiveRecord::Migration[8.1]
  def change
    add_column :membership_fees, :review_note, :text
    add_column :membership_fees, :reviewed_at, :datetime
  end
end
