class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :seance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
