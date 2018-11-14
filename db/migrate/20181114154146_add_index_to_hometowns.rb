class AddIndexToHometowns < ActiveRecord::Migration[5.2]
  def change
    add_index :hometowns, :city
    add_index :hometowns, :number_traveller
    add_index :hometowns, :date_from
    add_index :hometowns, :date_to
  end
end
