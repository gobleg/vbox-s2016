class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :eid
      t.references :user, index: true, foreign_key: true
      #t.attachment :video

      t.timestamps null: false
    end
  end
end
