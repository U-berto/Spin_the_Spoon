class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :city, :string
    add_column :users, :public, :boolean, default: false
  end
end
