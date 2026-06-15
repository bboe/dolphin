# frozen_string_literal: true

class AddUniqueIndexToBlacklistedEmailsEmail < ActiveRecord::Migration[8.1]
  def change
    add_index :blacklisted_emails, :email, unique: true
  end
end
