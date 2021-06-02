class CreateTicketDesks < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_desks do |t|
      t.boolean :online

      t.timestamps
    end
  end
end
