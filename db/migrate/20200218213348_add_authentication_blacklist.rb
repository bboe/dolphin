class AddAuthenticationBlacklist < ActiveRecord::Migration[6.0]
  def change
    create_table(:blacklisted_emails) do |t|
      t.string :email, null: false
      t.timestamps null: false
    end
  end
end
