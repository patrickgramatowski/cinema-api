class UpdateStatusInReservation < ActiveRecord::Migration[6.1]
  def up
    change_table :reservations do |t|
      t.change :status, :string
    end
  end

  def down
    change_table :reservations do |t|
      t.change :status, :string, default: "pending"
    end
  end
end
