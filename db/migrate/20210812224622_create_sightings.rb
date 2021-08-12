class CreateSightings < ActiveRecord::Migration[6.1]
  def change
    create_table :sightings do |t|
      t.integer :animal_id
      t.datetime :date
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
