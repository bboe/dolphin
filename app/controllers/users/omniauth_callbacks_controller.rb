# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    FAILURE_PATH = 'https://www.google.com'

    def after_omniauth_failure_path_for(_scope)
      FAILURE_PATH
    end

    def google_oauth2
      access_token = request.env['omniauth.auth']
      domain_list = Rails.configuration.google_client_domain_list
      domain = access_token.info.email.split('@')[1]
      if domain_list.present? && !domain_list.include?(domain)
        redirect_to FAILURE_PATH
        return
      end

      user = create_or_update_user(access_token)
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success',
                              kind: domain)
      sign_in_and_redirect user, event: :authentication
    end

    private

    def create_or_update_user(access_token)
      id_args = { provider: access_token.provider, uid: access_token.uid }
      info_args = {
        name: access_token.info.name,
        email: access_token.info.email,
        image_url: access_token.info.image
      }

      if (user = User.find_by(**id_args))
        user.update_attributes(**info_args)
      else
        user = User.create!(**info_args.merge!(id_args))
      end
      user
    end
  end
end
