class Dolphin < ActiveRecord::Base
  belongs_to :from, class_name: :User
  belongs_to :to, class_name: :User

  validates_presence_of :from, :to, message: 'invalid user'
  validates_presence_of :source
end
