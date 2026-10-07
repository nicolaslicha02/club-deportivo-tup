class CreateMembershipFees < ActiveRecord::Migration[8.1]
  def change
    create_table :membership_fees do |t|
      t.references :member_profile, null: false, foreign_key: true
      t.string :period
      t.decimal :amount
      t.date :due_date
      t.integer :status

      t.timestamps
    end
  end
end
