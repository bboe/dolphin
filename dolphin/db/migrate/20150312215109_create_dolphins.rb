class CreateDolphins < ActiveRecord::Migration
  def change
    create_table :dolphins do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.string :source, null: false

      t.timestamps null: false
    end
  end
end
