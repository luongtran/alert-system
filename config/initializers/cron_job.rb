require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

#scheduler.cron("0 59 23 * * 1-5") do
#  User.daily_checker
#end

# cron test
scheduler.every("12h") do
  User.daily_checker
end