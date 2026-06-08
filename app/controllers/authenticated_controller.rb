# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action do
    redirect_to login_path unless user_signed_in?
  end
end
