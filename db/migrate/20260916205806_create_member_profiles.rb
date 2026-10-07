class CreateMemberProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :member_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :dni
      t.string :member_number
      t.string :phone
      t.date :birth_date
      t.integer :status

      t.timestamps
    end
  end
end
