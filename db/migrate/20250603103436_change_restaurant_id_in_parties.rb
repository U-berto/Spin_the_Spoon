class ChangeRestaurantIdInParties < ActiveRecord::Migration[7.1]
  def change
    change_column :parties, :restaurant_id, :bigint, null: true
  end
end
