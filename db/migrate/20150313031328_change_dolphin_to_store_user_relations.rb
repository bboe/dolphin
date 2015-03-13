class ChangeDolphinToStoreUserRelations < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up { execute('TRUNCATE dolphins') }
    end

    remove_column :dolphins, :from, :string, null: false
    remove_column :dolphins, :to, :string, null: false

    add_reference :dolphins, :from, index: true, null: false
    add_reference :dolphins, :to, index: true, null: false

    add_foreign_key :dolphins, :users, column: :from_id
    add_foreign_key :dolphins, :users, column: :to_id

    reversible do |dir|
      dir.down { execute('TRUNCATE dolphins') }
    end

  end
end
