class CreateActivities < ActiveRecord::Migration[8.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.decimal :monthly_fee
      t.integer :capacity
      t.boolean :active

      t.timestamps
    end
  end
end
