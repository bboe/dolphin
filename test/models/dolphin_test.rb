# frozen_string_literal: true

require 'test_helper'
require_relative 'user_test'

class DolphinTest < ActiveSupport::TestCase
  test 'dolphin time limit' do
    (user1 = new_user).save!
    (user2 = new_user(email: 'user2@test', uid: 2)).save!
    (user3 = new_user(email: 'user3@test', uid: 3)).save!
    new_dolphin(from: user2, to: user1).save!

    dolphin = new_dolphin(from: user3, to: user1)
    assert_predicate dolphin, :invalid?
    assert_equal({ from: ['Test User was dolphined within the last 10 minutes by Test User. Please log Test User out (ctrl+shift+eject on OS X).'] }, dolphin.errors.messages)
  end

  test 'presence of from' do
    dolphin = new_dolphin(from: nil)
    assert_predicate dolphin, :invalid?
    assert_equal({ from: ['must exist', 'invalid user'] }, dolphin.errors.messages)
  end

  test 'presence of source' do
    [nil, ''].each do |value|
      dolphin = new_dolphin(source: value)
      assert_predicate dolphin, :invalid?
      assert_equal({ source: ["can't be blank"] }, dolphin.errors.messages)
    end
  end

  test 'presence of to' do
    dolphin = new_dolphin(to: nil)
    assert_predicate dolphin, :invalid?
    assert_equal({ to: ['must exist', 'invalid user'] }, dolphin.errors.messages)
  end

  test 'prevent self dolphin' do
    (user = new_user).save!
    dolphin = new_dolphin(from: user, to: user)
    assert_predicate dolphin, :invalid?
    assert_equal({ from: ['cannot dolphin yourself'] }, dolphin.errors.messages)
  end

  test 'self.top has invalid parameters' do
    [nil, :foo, '', 'foo', :foo, 1, [], {}].each do |arg|
      assert_raises(ArgumentError) { Dolphin.top(by: arg) }
    end
  end

  test 'self.top limits results' do
    users = []
    16.times do |i|
      (user = new_user(email: "u#{i}@test", uid: i)).save!
      users << user
    end

    16.times do |i|
      new_dolphin(from: users[i % 16], to: users[(i + 1) % 16]).save!
    end

    assert_equal User.count, Dolphin.top(by: :from, limit: nil).count
    [0, 1, 7, User.count - 1, User.count].each do |limit|
      assert_equal limit, Dolphin.top(by: :from, limit: limit).count
    end
  end

  test 'self.top order by from' do
    users = []
    4.times do |i|
      (user = new_user(email: "u#{i}@test", uid: i)).save!
      users << user
    end

    u1_time = Time.zone.now - 3600

    # Send an equal number of dolphins from each user
    2.upto(3) do |i|
      new_dolphin(from: users[0], to: users[i],
                  created_at: u1_time, updated_at: u1_time).save!
      new_dolphin(from: users[1], to: users[i],
                  created_at: u1_time + 1, updated_at: u1_time + 1).save!
    end
    assert_equal users[0].reload.from_count, users[1].reload.from_count
    assert_equal users[0].to_count, users[1].to_count
    assert_equal [users[0], users[1]], Dolphin.top(by: :from, limit: 2).to_a

    # Have u1 receive a dolphin
    new_dolphin(from: users[2], to: users[0]).save!
    assert_equal users[0].reload.from_count, users[1].reload.from_count
    assert_operator users[0].to_count, :>, users[1].to_count
    assert_equal [users[1], users[0]], Dolphin.top(by: :from, limit: 2).to_a

    # Increase u1's from count
    new_dolphin(from: users[0], to: users[-1]).save!
    assert_operator users[0].reload.from_count, :>, users[1].reload.from_count
    assert_equal [users[0], users[1]], Dolphin.top(by: :from, limit: 2).to_a
  end

  test 'self.top order by to' do
    users = []
    4.times do |i|
      (user = new_user(email: "u#{i}@test", uid: i)).save!
      users << user
    end

    u1_time = Time.zone.now - 3600

    # Send an equal number of dolphins from each user
    2.upto(3) do |i|
      new_dolphin(from: users[i], to: users[0],
                  created_at: u1_time, updated_at: u1_time).save!
      new_dolphin(from: users[i], to: users[1],
                  created_at: u1_time + 1, updated_at: u1_time + 1).save!
    end
    assert_equal users[0].reload.from_count, users[1].reload.from_count
    assert_equal users[0].to_count, users[1].to_count
    assert_equal [users[0], users[1]], Dolphin.top(by: :to, limit: 2).to_a

    # Have u1 send a dolphin
    new_dolphin(from: users[0], to: users[2]).save!
    assert_operator users[0].reload.from_count, :>, users[1].reload.from_count
    assert_equal users[0].to_count, users[1].to_count
    assert_equal [users[1], users[0]], Dolphin.top(by: :to, limit: 2).to_a

    # Increase u1's to count
    new_dolphin(from: users[-1], to: users[0]).save!
    assert_operator users[0].reload.to_count, :>, users[1].reload.to_count
    assert_equal [users[0], users[1]], Dolphin.top(by: :to, limit: 2).to_a
  end

  test 'valid dolphin' do
    assert_predicate new_dolphin, :valid?
  end
end
