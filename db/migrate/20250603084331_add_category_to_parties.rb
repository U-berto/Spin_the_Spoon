class AddCategoryToParties < ActiveRecord::Migration[7.1]
  def change
    add_column :parties, :category, :string
  end
end
