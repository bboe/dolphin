class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  rescue_from ActionView::MissingTemplate do
    # RAILS5TODO: Remove this rescue when upgrading to rails5.
    raise unless Rails.env.production?
    render nothing: true, status: :not_acceptable
  end

  def ssl_configured?
    Rails.env.production?
  end
end
