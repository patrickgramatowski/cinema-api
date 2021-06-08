class AddSeatsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :seats, :string
  end
end
