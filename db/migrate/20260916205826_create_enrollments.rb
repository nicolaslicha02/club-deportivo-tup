class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :member_profile, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.date :start_date
      t.boolean :active

      t.timestamps
    end
  end
end
