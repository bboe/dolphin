class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    unless user_signed_in?
      redirect_to user_omniauth_authorize_path(:google_oauth2)
    end
  end
end
