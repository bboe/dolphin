class RemoveSelfDolphins < ActiveRecord::Migration
  def change
    execute <<-SQL
      delete from dolphins where to_id = from_id
    SQL
  end
end
