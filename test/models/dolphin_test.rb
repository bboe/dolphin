require 'test_helper'
require_relative 'user_test'

class DolphinTest < ActiveSupport::TestCase

  test 'dolphin time limit' do
    assert create_dolphin(from: users(:user2), to: users(:user1)).save
    dolphin = create_dolphin(from: users(:user3), to: users(:user1))
    assert dolphin.invalid?, 'can only be dolphined once every 10 minutes'
    assert_equal [:from], dolphin.errors.keys
  end

  test 'presence of fields' do
    assert (dolphin = Dolphin.new).invalid?, 'missing required fields'
    assert_equal [:from, :to, :source], dolphin.errors.keys
  end

  test 'prevent self dolphin' do
    dolphin = create_dolphin(from: users(:user1), to: users(:user1))
    assert dolphin.invalid?, 'to and from cannot be the same'
    assert_equal [:from], dolphin.errors.keys
  end

  test 'self.top has invalid parameters' do
    [nil, :foo, '', 'foo', :'foo', 1, [], {}].each do |arg|
      assert_raises(ArgumentError) { Dolphin.top(by: arg) }
    end
  end

  test 'self.top limits results' do
    assert_equal User.count, Dolphin.top(by: :from, limit: nil).count
    [0, 1, 7, User.count - 1, User.count].each do |limit|
      assert_equal limit, Dolphin.top(by: :from, limit: limit).count
    end
  end

  test 'self.top order by from' do
    u1 = create_user(email: 'u1@test', uid: '01').tap { |u| u.save! }
    u2 = create_user(email: 'u2@test', uid: '02').tap { |u| u.save! }

    u1_time = Time.zone.now() - 3600

    # Send an equal number of dolphins from each user
    1.upto(4) do |i|
      create_dolphin(from: u1, to: users("user#{i}"),
                     created_at: u1_time, updated_at: u1_time).save!
      create_dolphin(from: u2, to: users("user#{i}"),
                     created_at: u1_time + 1, updated_at: u1_time + 1).save!
    end
    assert_equal u1.reload.from_count, u2.reload.from_count
    assert_equal u1.to_count, u2.to_count
    assert_equal [u1, u2], Dolphin.top(by: :from, limit: 2).to_a

    # Have u1 receive a dolphin
    create_dolphin(from: users(:user1), to: u1).save!
    assert_equal u1.reload.from_count, u2.reload.from_count
    assert u1.to_count > u2.to_count
    assert_equal [u2, u1], Dolphin.top(by: :from, limit: 2).to_a

    # Increase u1's from count
    create_dolphin(from: u1, to: users(:user5)).save!
    assert u1.reload.from_count > u2.reload.from_count
    assert_equal [u1, u2], Dolphin.top(by: :from, limit: 2).to_a
  end

  test 'self.top order by to' do
    u1 = create_user(email: 'u1@test', uid: '01').tap { |u| u.save! }
    u2 = create_user(email: 'u2@test', uid: '02').tap { |u| u.save! }

    # Send an equal number of dolphins from each user
    4.times do |i|
      dtime = Time.zone.now - 3600 + i * 600
      create_dolphin(from: users(:user1), to: u1,
                     created_at: dtime, updated_at: dtime).save!
      create_dolphin(from: users(:user1), to: u2,
                     created_at: dtime, updated_at: dtime + 1).save!
    end
    assert_equal u1.reload.from_count, u2.reload.from_count
    assert_equal u1.to_count, u2.to_count
    assert_equal [u1, u2], Dolphin.top(by: :to, limit: 2).to_a

    # Have u1 send a dolphin
    create_dolphin(from: u1, to: users(:user1)).save!
    assert u1.reload.from_count > u2.reload.from_count
    assert_equal u1.to_count, u2.to_count
    assert_equal [u2, u1], Dolphin.top(by: :to, limit: 2).to_a

    # Increase u1's to count
    create_dolphin(from: users(:user5), to: u1).save!
    assert u1.reload.to_count > u2.reload.to_count
    assert_equal [u1, u2], Dolphin.top(by: :to, limit: 2).to_a
  end

  test 'valid dolphin' do
    assert create_dolphin.valid?
  end
end
