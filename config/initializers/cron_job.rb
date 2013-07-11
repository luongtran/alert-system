require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
scheduler.every("15s") do
  User.daily_checker
end