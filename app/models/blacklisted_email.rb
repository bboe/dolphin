class BlacklistedEmail < ApplicationRecord
    validates :email, presence: true, uniqueness: true
end