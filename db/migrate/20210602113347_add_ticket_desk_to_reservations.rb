class AddTicketDeskToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :ticket_desk, null: false, foreign_key: true
  end
end
