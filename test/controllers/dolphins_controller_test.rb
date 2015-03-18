require 'test_helper'

class DolphinsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in users(:user1)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:dolphins)
    assert_not_nil assigns(:top_froms)
    assert_not_nil assigns(:top_tos)
  end

  test 'should create dolphin' do
    assert_difference('Dolphin.count') do
      post :create, dolphin: { source: 'Test', from: users(:user2).email }
    end

    assert (dolphin = assigns(:dolphin))
    assert_equal users(:user2), dolphin.from
    assert_equal users(:user1), dolphin.to

    assert_redirected_to dolphins_path
  end

  test 'should create dolphin via domained email' do
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
    assert_no_difference('Dolphin.count') do
      post :create, dolphin: { source: 'Test', from: '2' }
    end

    assert (dolphin = assigns(:dolphin))
    assert_nil dolphin.from
    assert_response :bad_request
  end

end
