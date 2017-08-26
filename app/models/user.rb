# frozen_string_literal: true

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, :name, :image_url, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :nickname, allow_nil: true, presence: true, uniqueness: true
  validates :uid, uniqueness: { scope: :provider }

  has_many :dolphins_sent, class_name: :Dolphin, foreign_key: :from_id
  has_many :dolphins_received, class_name: :Dolphin, foreign_key: :to_id
end
