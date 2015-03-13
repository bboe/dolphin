class Dolphin < ActiveRecord::Base
  belongs_to :from, class_name: :User, counter_cache: :from_count
  belongs_to :to, class_name: :User, counter_cache: :to_count

  validates_presence_of :from, :to, message: 'invalid user'
  validates_presence_of :source

  validate :dolphin_yourself

  def self.top(by:, limit: 10)
    unless [:from, :to].include?(by.to_sym)
      raise ArgumentError.new('invalid `by` parameter')
    end
    User.order("#{by}_count desc").limit(limit)
  end

  private

  def dolphin_yourself
    errors.add(:from, 'cannot dolphin yourself') if from == to
  end
end
