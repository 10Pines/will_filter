class CreateWillFilterFilters < ActiveRecord::Migration[4.2]
  def self.up
    create_table :will_filter_filters do |t|
      t.string      :type
      t.string      :name
      t.text        :data
      t.integer     :user_id
      t.string      :model_class_name
      
      t.timestamps
    end
    
    add_index :will_filter_filters, [:user_id]
  end
  
  def self.down
    drop_table :will_filter_filters
  end
end
