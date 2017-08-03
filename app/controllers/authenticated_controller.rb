class AuthenticatedController < ApplicationController
  before_action do
    unless user_signed_in?
      redirect_to user_google_oauth2_omniauth_authorize_path
    end
  end
end
