class CreateObds < ActiveRecord::Migration
  def change
    create_table :obds do |t|
      t.datetime :time
      t.decimal :rpm
      t.decimal :mph
      t.decimal :throttle
      t.decimal :intake_air_temp
      t.decimal :fuel_status
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
