class ChangeDateFormatInSeances < ActiveRecord::Migration[6.1]
  def change
    def up
      change_column :seances, :time, :datetime
    end
  
    def down
      change_column :seances, :time, :time
    end
  end
end
