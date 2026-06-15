# frozen_string_literal: true

class BlacklistedEmail < ApplicationRecord
  validates :email, presence: true, uniqueness: true
end
