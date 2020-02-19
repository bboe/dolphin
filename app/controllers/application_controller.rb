# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def blacklisted
    render 'blacklisted', layout: false
  end

  def ip_address
    request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
  end

  def ssl_configured?
    Rails.env.production?
  end
end
