# frozen_string_literal: true

class Dolphin < ApplicationRecord
  belongs_to :from, class_name: :User, counter_cache: :from_count
  belongs_to :to, class_name: :User, counter_cache: :to_count

  validates :from, :to, presence: { message: 'invalid user' }
  validates :source, presence: true

  validate :dolphin_yourself
  validate :dolphin_timelimit

  def self.top(by:, limit: 8)
    unless %i[from to].include?(by.try(:to_sym))
      raise ArgumentError, 'invalid `by` parameter'
    end

    query = User.where("#{by}_count > 0")

    if by == :from
      query.order(from_count: :desc, to_count: :asc, updated_at: :asc)
    else
      query.order(to_count: :desc, from_count: :asc, updated_at: :asc)
    end.limit(limit)
  end

  private

  def dolphin_timelimit
    dolphin = Dolphin.where(to_id: to_id).where("created_at > now() - interval '10 minutes'").first
    return unless dolphin
    message = "#{to.name} was dolphined within the last 10 minutes by "\
              "#{dolphin.from.name}. Please log #{to.name} out "\
              '(ctrl+shift+eject on OS X).'
    errors.add(:from, message)
  end

  def dolphin_yourself
    errors.add(:from, 'cannot dolphin yourself') if from == to
  end
end
