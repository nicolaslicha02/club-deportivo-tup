class CreateClubSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :club_settings do |t|
      t.decimal :base_fee

      t.timestamps
    end
  end
end
