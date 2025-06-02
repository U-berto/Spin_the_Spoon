class RenameCityToAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column(:users, :city, :address)
  end
end
