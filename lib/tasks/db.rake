# frozen_string_literal: true

namespace :db do
  desc 'Update sent and received counts on users'
  task recount: :environment do
    User.all.find_each do |user|
      User.reset_counters(user.id, :dolphins_sent, :dolphins_received)
    end
  end
end
