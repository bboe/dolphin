# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    FAILURE_PATH = 'https://www.google.com'

    def google_oauth2
      access_token = request.env['omniauth.auth']
      if Rails.configuration.google_client_domain != access_token.extra.raw_info.hd
        redirect_to FAILURE_PATH
        return
      end

      id_args = { provider: access_token.provider, uid: access_token.uid }
      info_args = {
        name: access_token.info.name,
        email: access_token.info.email,
        image_url: access_token.info.image
      }

      if user = User.find_by(**id_args)
        user.update_attributes(**info_args)
      else
        user = User.create!(**info_args.merge!(id_args))
      end

      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: 'Google')
      sign_in_and_redirect user, event: :authentication
    end

    def after_omniauth_failure_path_for(_scope)
      FAILURE_PATH
    end
  end
end
