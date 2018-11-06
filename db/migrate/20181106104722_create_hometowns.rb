class CreateHometowns < ActiveRecord::Migration[5.2]
  def change
    create_table :hometowns do |t|
      t.string :city
      t.integer :number_traveller
      t.date :date_from
      t.date :date_to
      t.json :results
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
