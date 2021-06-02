class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.string :seat
      t.string :ticket_type
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
