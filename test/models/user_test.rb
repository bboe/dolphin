# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user destroys when has been dolphined' do
    (user1 = new_user).save!
    (user2 = new_user(email: 'user2@test', uid: 2)).save!
    new_dolphin(from: user2, to: user1).save!

    assert_predicate user1, :destroy
  end

  test 'user destroys when has dolphined' do
    (user1 = new_user).save!
    (user2 = new_user(email: 'user2@test', uid: 2)).save!
    new_dolphin(from: user2, to: user1).save!

    assert_predicate user2, :destroy
  end

  test 'user fails to save with blank nickname' do
    user = new_user(nickname: '')
    assert_predicate user, :invalid?
    assert_equal({ nickname: ["can't be blank"] }, user.errors.messages)
  end

  test 'user fails to save with duplicate nickname' do
    new_user(nickname: 'a').save!

    user = new_user(email: 'b', nickname: 'a', uid: '2')
    assert_predicate user, :invalid?
    assert_equal({ nickname: ['has already been taken'] }, user.errors.messages)
  end

  test 'user fails to save with duplicate email' do
    new_user.save!

    user = new_user(uid: '02')
    assert_predicate user, :invalid?
    assert_equal({ email: ['has already been taken'] }, user.errors.messages)
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
      assert_equal({ email: ["can't be blank"] }, user.errors.messages)
    end
  end

  test 'user fails to save without image_url' do
    [nil, ''].each do |value|
      user = new_user(image_url: value)
      assert_predicate user, :invalid?
      assert_equal({ image_url: ["can't be blank"] }, user.errors.messages)
    end
  end

  test 'user fails to save without name' do
    [nil, ''].each do |value|
      user = new_user(name: value)
      assert_predicate user, :invalid?
      assert_equal({ name: ["can't be blank"] }, user.errors.messages)
    end
  end

  test 'user fails to save without provider' do
    [nil, ''].each do |value|
      user = new_user(provider: value)
      assert_predicate user, :invalid?
      assert_equal({ provider: ["can't be blank"] }, user.errors.messages)
    end
  end

  test 'user fails to save without uid' do
    [nil, ''].each do |value|
      user = new_user(uid: value)
      assert_predicate user, :invalid?
      assert_equal({ uid: ["can't be blank"] }, user.errors.messages)
    end
  end

  test 'user saves when valid' do
    assert_predicate new_user, :valid?
  end
end
