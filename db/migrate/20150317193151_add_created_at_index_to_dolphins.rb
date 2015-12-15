class AddCreatedAtIndexToDolphins < ActiveRecord::Migration
  def change
    add_index :dolphins, :created_at
  end
end
