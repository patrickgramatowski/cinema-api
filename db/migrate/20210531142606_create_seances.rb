class CreateSeances < ActiveRecord::Migration[6.1]
  def change
    create_table :seances do |t|
      t.date :date
      t.time :time
      t.references :movie, null: false, foreign_key: true
      t.references :hall, null: false, foreign_key: true

      t.timestamps
    end
  end
end
