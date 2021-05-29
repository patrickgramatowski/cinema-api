class CreateHalls < ActiveRecord::Migration[6.1]
  def change
    create_table :halls do |t|
      t.string :hall
      t.integer :seats

      t.timestamps
    end
  end
end
