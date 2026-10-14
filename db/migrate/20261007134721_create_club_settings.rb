class CreateClubSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :club_settings, if_not_exists: true do |t|
      t.decimal :base_fee

      t.timestamps
    end
  end
end
