require 'test_helper'

class DolphinsControllerTest < ActionController::TestCase
  setup do
    @dolphin = dolphins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dolphins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dolphin" do
    assert_difference('Dolphin.count') do
      post :create, dolphin: { from: @dolphin.from, source: @dolphin.source, to: @dolphin.to }
    end

    assert_redirected_to dolphin_path(assigns(:dolphin))
  end

  test "should show dolphin" do
    get :show, id: @dolphin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dolphin
    assert_response :success
  end

  test "should update dolphin" do
    patch :update, id: @dolphin, dolphin: { from: @dolphin.from, source: @dolphin.source, to: @dolphin.to }
    assert_redirected_to dolphin_path(assigns(:dolphin))
  end

  test "should destroy dolphin" do
    assert_difference('Dolphin.count', -1) do
      delete :destroy, id: @dolphin
    end

    assert_redirected_to dolphins_path
  end
end
