# frozen_string_literal: true

require 'test_helper'

class OmniAuthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should get google_oauth2 callback when allowing all domains' do
    mock_omniauth

    begin
      previous_setting = Rails.configuration.google_client_domain_list
      Rails.configuration.google_client_domain_list = []

      assert_difference 'User.count' do
        get user_google_oauth2_omniauth_callback_path
      end
      assert_redirected_to root_path
      assert_equal 'Successfully authenticated from Google account.', flash['notice']
    ensure
      Rails.configuration.google_client_domain_list = previous_setting
    end
  end


  test 'should get google_oauth2 callback with existing user' do
    mock_omniauth
    (user = new_user).save!

    previous_email = user.email
    previous_image_url = user.image_url
    previous_name = user.name

    assert_no_difference 'User.count' do
      get user_google_oauth2_omniauth_callback_path
    end
    assert_redirected_to root_path
    assert_equal 'Successfully authenticated from Google account.', flash['notice']

    user.reload
    assert_not_equal previous_email, user.email
    assert_not_equal previous_image_url, user.image_url
    assert_not_equal previous_name, user.name
  end

  test 'should get google_oauth2 callback with new user' do
    mock_omniauth

    assert_difference 'User.count' do
      get user_google_oauth2_omniauth_callback_path
    end
    assert_redirected_to root_path
    assert_equal 'Successfully authenticated from Google account.', flash['notice']
  end

  test 'should get google_oauth2 callback with invalid domain' do
    mock_omniauth(hd: 'invalid')

    assert_no_difference 'User.count' do
      get user_google_oauth2_omniauth_callback_path
    end
    assert_redirected_to 'https://www.google.com'
    assert_nil flash['notice']
  end

  private

  def mock_omniauth(hd: 'test')
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      extra: { raw_info: { hd: hd } },
      info: { email: 'a@a', image: 'a', name: 'a' },
      provider: 'test',
      uid: '0'
    )
  end
end
