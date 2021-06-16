class RemoveSeatsFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :seats, :string
  end
end
