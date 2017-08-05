require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user fails to save with duplicate email' do
    new_user.save!

    user = new_user(uid: '02')
    assert_predicate user, :invalid?
    assert_equal({email: ["has already been taken"]}, user.errors.messages)
  end

  test 'user fails to save with duplicate provider and uid' do
    new_user.save!

    user = new_user(email: 'user2@test')
    assert_predicate user, :invalid?
    assert_equal({ uid: ['has already been taken'] }, user.errors.messages)
  end

  test 'user fails to save without email' do
    [nil, ''].each do |value|
      user = new_user(email: value)
      assert_predicate user, :invalid?
      assert_equal({email: ["can't be blank"]}, user.errors.messages)
    end
  end

  test 'user fails to save without image_url' do
    [nil, ''].each do |value|
      user = new_user(image_url: value)
      assert_predicate user, :invalid?
      assert_equal({image_url: ["can't be blank"]}, user.errors.messages)
    end
  end

  test 'user fails to save without name' do
    [nil, ''].each do |value|
      user = new_user(name: value)
      assert_predicate user, :invalid?
      assert_equal({name: ["can't be blank"]}, user.errors.messages)
    end
  end

  test 'user fails to save without provider' do
    [nil, ''].each do |value|
      user = new_user(provider: value)
      assert_predicate user, :invalid?
      assert_equal({provider: ["can't be blank"]}, user.errors.messages)
    end
  end

  test 'user fails to save without uid' do
    [nil, ''].each do |value|
      user = new_user(uid: value)
      assert_predicate user, :invalid?
      assert_equal({uid: ["can't be blank"]}, user.errors.messages)
    end
  end


  test 'user saves when valid' do
    assert_predicate new_user, :valid?
  end
end
