class Dolphin < ActiveRecord::Base
  belongs_to :from, class_name: :User, counter_cache: :from_count
  belongs_to :to, class_name: :User, counter_cache: :to_count

  validates_presence_of :from, :to, message: 'invalid user'
  validates_presence_of :source

  validate :dolphin_yourself
  validate :dolphin_timelimit

  def self.top(by:, limit: 10)
    unless [:from, :to].include?(by.to_sym)
      raise ArgumentError.new('invalid `by` parameter')
    end
    User.order("#{by}_count desc").where("#{by}_count > 0").limit(limit)
  end

  private

  def dolphin_timelimit
    if Dolphin.where(to_id: to_id).where("created_at > now() - interval '10 minutes'").first
      errors.add(:from, 'user was already dolphined within the last 10 minutes')
    end
  end

  def dolphin_yourself
    errors.add(:from, 'cannot dolphin yourself') if from == to
  end
end
