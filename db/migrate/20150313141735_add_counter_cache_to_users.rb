class AddCounterCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :from_count, :integer, null: false, default: 0
    add_column :users, :to_count, :integer, null: false, default: 0

    add_index :users, :from_count
    add_index :users, :to_count
  end
end
