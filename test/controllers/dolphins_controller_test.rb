require 'test_helper'

class DolphinsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index when not logged in' do
    get :index
    assert_redirected_to user_google_oauth2_omniauth_authorize_path
  end

  test 'should get index' do
    login
    get :index
    assert_response :ok
    assert_not_nil assigns(:dolphins)
    assert_not_nil assigns(:top_froms)
    assert_not_nil assigns(:top_tos)
  end

  test 'should create dolphin' do
    login
    assert_difference('Dolphin.count') do
      post :create, dolphin: { source: 'Test', from: users(:user2).email }
    end

    assert (dolphin = assigns(:dolphin))
    assert_equal users(:user2), dolphin.from
    assert_equal users(:user1), dolphin.to

    assert_redirected_to dolphins_path
  end

  test 'should create dolphin via domained email' do
    login
    ENV.stubs(:[]).returns(nil)
    ENV.expects(:[]).with('GOOGLE_CLIENT_DOMAIN').returns('test')

    assert_difference('Dolphin.count') do
      post :create, dolphin: { source: 'Test', from: '2' }
    end

    assert (dolphin = assigns(:dolphin))
    assert_equal users(:user2), dolphin.from
    assert_equal users(:user1), dolphin.to

    assert_redirected_to dolphins_path
  end

  test 'should not create dolphin via invalid email' do
    login
    assert_no_difference('Dolphin.count') do
      post :create, dolphin: { source: 'Test', from: '2' }
    end

    assert (dolphin = assigns(:dolphin))
    assert_nil dolphin.from
    assert_response :bad_request
  end

  private

  def login
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in users(:user1)
  end
end
