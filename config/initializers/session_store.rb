# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

if Rails.env.production?
    Rails.application.config.session_store :cookie_store, domain: "dolphinfolio.com", expire_after: 9999.days, key: '_dolphin_session'
else
    Rails.application.config.session_store :cookie_store, expire_after: 9999.days, key: '_dolphin_session'
end
