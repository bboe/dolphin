# frozen_string_literal: true

class RemoveSelfDolphins < ActiveRecord::Migration
  def down; end

  def up
    execute <<-SQL
      delete from dolphins where to_id = from_id
    SQL
  end
end
