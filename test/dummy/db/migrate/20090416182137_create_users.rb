class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    create_table :users do |t|
      t.string    :first_name
      t.string    :last_name
      t.date      :birthday
      t.string    :sex
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
