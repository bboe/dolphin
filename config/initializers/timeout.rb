# frozen_string_literal: true

if Rails.env.production?
  Rack::Timeout.timeout = 5 # seconds
end
