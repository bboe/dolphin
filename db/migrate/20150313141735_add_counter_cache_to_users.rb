# frozen_string_literal: true

class AddCounterCacheToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users, bulk: true do |t|
      t.integer :from_count, null: false, default: 0
      t.integer :to_count, null: false, default: 0
      t.index :from_count
      t.index :to_count
    end
  end
end
