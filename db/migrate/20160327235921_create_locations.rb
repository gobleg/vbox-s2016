class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lat
      t.decimal :lng
      t.datetime :time

      t.timestamps null: false
    end
  end
end
