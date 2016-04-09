class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.datetime :time
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
