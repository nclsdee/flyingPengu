class AddDirectOnlyToHometowns < ActiveRecord::Migration[5.2]
  def change
    add_column :hometowns, :direct, :boolean, default: false
  end
end
