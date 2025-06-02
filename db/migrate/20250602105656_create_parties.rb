class CreateParties < ActiveRecord::Migration[7.1]
  def change
    create_table :parties do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.string :risk_level

      t.timestamps
    end
  end
end
