# frozen_string_literal: true

class AddCreatedAtIndexToDolphins < ActiveRecord::Migration[4.2]
  def change
    add_index :dolphins, :created_at
  end
end
