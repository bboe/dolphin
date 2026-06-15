# frozen_string_literal: true

class ChangeDolphinToStoreUserRelations < ActiveRecord::Migration[4.2]
  def change
    # The dolphins table is repurposed (string names -> user references), so its
    # rows are discarded in both directions.
    reversible do |dir|
      dir.up   { execute('TRUNCATE dolphins') }
      dir.down { execute('TRUNCATE dolphins') }
    end

    change_table :dolphins, bulk: true do |t|
      t.remove :from, type: :string
      t.remove :to, type: :string
      t.references :from, index: true
      t.references :to, index: true
      t.foreign_key :users, column: :from_id
      t.foreign_key :users, column: :to_id
    end

    # Table is empty (truncated above), so marking the new references NOT NULL is
    # safe; one ALTER avoids adding a non-null column directly.
    reversible do |dir|
      dir.up { execute('ALTER TABLE dolphins ALTER COLUMN from_id SET NOT NULL, ALTER COLUMN to_id SET NOT NULL') }
    end
  end
end
