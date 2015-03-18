require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'presence of fields' do
    assert (user = User.new).invalid?, 'missing required fields'
    assert_equal [:email, :name, :image_url, :provider, :uid], user.errors.keys
  end

  test 'duplicate email' do
    assert create_user(uid: '01').save
    assert (user = create_user(uid: '02')).invalid?, 'email must be unique'
    assert_equal [:email], user.errors.keys
  end

  test 'duplicate provider and uid' do
    assert create_user(email: 'user1@test').save
    assert (user = create_user(email: 'user2@test')).invalid?,
           'provider and uid must be unique'
    assert_equal [:uid], user.errors.keys
  end

  test 'valid user' do
    assert create_user.valid?
  end
end
