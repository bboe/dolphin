ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_dolphin(from: users(:user1), to: users(:user2), source: 'Test',
                     created_at: nil, updated_at: nil)
    Dolphin.new(from: from, to: to, source: source, created_at: created_at,
                updated_at: updated_at)
  end

  def create_user(email: 'test@test', name: 'Test User', image_url: '.',
                  provider: 'test', uid: '01')
    User.new(email: email, name: name, image_url: image_url, provider: provider,
             uid: uid)
  end
end
