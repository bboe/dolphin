# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/test_unit'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    OmniAuth.config.test_mode = true
    Rails.configuration.google_client_domain_list = %w[test]

    def new_dolphin(from: :default, to: :default, source: 'Test',
                    created_at: nil, updated_at: nil)
      from = new_user if from == :default
      to = new_user(email: 'test2@test', uid: '2') if to == :default
      Dolphin.new(from: from, to: to, source: source, created_at: created_at,
                  updated_at: updated_at)
    end

    def new_user(email: 'test@test', image_url: '/', name: 'Test User',
                 nickname: nil, provider: 'test', uid: '0')
      User.new(email: email, image_url: image_url, name: name,
               nickname: nickname, provider: provider, uid: uid)
    end
  end
end
