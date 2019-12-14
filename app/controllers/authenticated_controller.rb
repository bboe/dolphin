# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action do
    redirect_to user_google_oauth2_omniauth_authorize_path unless user_signed_in?
  end
end
