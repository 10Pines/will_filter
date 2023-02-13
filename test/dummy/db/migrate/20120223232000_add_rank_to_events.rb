class AddRankToEvents < ActiveRecord::Migration[4.2]
  def change
  	add_column :events, :rank, :float
  end
end
