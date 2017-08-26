# frozen_string_literal: true

require 'test_helper'

class DolphinsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    login

    get root_path
    assert_response :ok
  end

  test 'should get index when not logged in' do
    get root_path
    assert_redirected_to user_google_oauth2_omniauth_authorize_path
  end

  test 'should create dolphin' do
    authenticated_user = login
    (other_user = new_user(email: 'user2@test', uid: '2')).save!

    assert_difference('Dolphin.count') do
      post dolphins_path, params: { dolphin: { source: 'Test', from: other_user.email } }
      assert_redirected_to root_path
    end

    dolphin = Dolphin.last
    assert_equal other_user, dolphin.from
    assert_equal authenticated_user, dolphin.to
  end

  test 'should create dolphin via domained email' do
    authenticated_user = login
    (other_user = new_user(email: 'user2@test', uid: '2')).save!

    assert_difference('Dolphin.count') do
      post dolphins_path, params: { dolphin: { source: 'Test', from: 'user2' } }
      assert_redirected_to root_path
    end

    dolphin = Dolphin.last
    assert_equal other_user, dolphin.from
    assert_equal authenticated_user, dolphin.to
  end

  test 'should create dolphin via nickname' do
    authenticated_user = login
    (other_user = new_user(email: 'user2@test', nickname: 'u2', uid: '2')).save!

    assert_difference('Dolphin.count') do
      post dolphins_path, params: { dolphin: { source: 'Test', from: 'u2' } }
      assert_redirected_to root_path
    end

    dolphin = Dolphin.last
    assert_equal other_user, dolphin.from
    assert_equal authenticated_user, dolphin.to
  end

  test 'should not create dolphin via invalid email' do
    login
    assert_no_difference('Dolphin.count') do
      post dolphins_path, params: { dolphin: { source: 'Test', from: '2' } }
      assert_response :bad_request
    end

    assert_nil Dolphin.last
  end

  test 'should not create dolphin via missing from' do
    login
    new_user(email: 'b', nickname: nil, uid: 'b').save!
    assert_no_difference('Dolphin.count') do
      post dolphins_path, params: { dolphin: { source: 'Test', from: nil } }
      assert_response :unprocessable_entity
    end

    assert_nil Dolphin.last
  end

  test 'should not create dolphin when not logged in' do
    get root_path
    assert_redirected_to user_google_oauth2_omniauth_authorize_path
  end

  private

  def login
    user = new_user
    user.save!
    sign_in user
    user
  end
end
