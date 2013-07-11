require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
scheduler.every("1h") do
  User.daily_checker
end