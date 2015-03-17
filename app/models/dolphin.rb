class Dolphin < ActiveRecord::Base
  belongs_to :from, class_name: :User, counter_cache: :from_count
  belongs_to :to, class_name: :User, counter_cache: :to_count

  validates_presence_of :from, :to, message: 'invalid user'
  validates_presence_of :source

  validate :dolphin_yourself
  validate :dolphin_timelimit

  def self.top(by:, limit: 16)
    unless [:from, :to].include?(by.to_sym)
      raise ArgumentError.new('invalid `by` parameter')
    end

    query = User.where("#{by}_count > 0")

    if by == :from
      query = query.order(from_count: :desc, to_count: :asc)
    else
      query = query.order(to_count: :desc, from_count: :asc)
    end

    query.limit(limit)
  end

  private

  def dolphin_timelimit
    if (dolphin = Dolphin.where(to_id: to_id).where("created_at > now() - interval '10 minutes'").first)
      errors.add(:from,
        "#{to.name} was dolphined within the last 10 minutes by #{dolphin.from.name}. Please log #{to.name} out (ctrl+shift+eject on OS X).")
    end
  end

  def dolphin_yourself
    errors.add(:from, 'cannot dolphin yourself') if from == to
  end
end
