class AuthenticatedController < ApplicationController
  before_action do
    unless user_signed_in?
      redirect_to user_omniauth_authorize_path(:google_oauth2)
    end
  end
end
