# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
#puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({:name => role}, :without_protection => true)
  puts 'role: ' << role
end
#free_role = Role.create(:name => 'free', :maximum_packages => 1, :unit_amount => 0)
#small_role = Role.create(:name => 'small', :maximum_packages => 3, :unit_amount => 5)
#medium_role = Role.create(:name => 'medium', :maximum_packages => 10, :unit_amount => 10)
#large_role = Role.create(:name => 'large', :maximum_packages => 30, :unit_amount => 15)

user1 = User.find_or_create_by_email :first_name => 'Free', :last_name => 'User', :email => 'free@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 1, :check_date_time => DateTime.now, :confirmed_at => DateTime.now
user1.add_role :free

user2 = User.find_or_create_by_email :first_name => 'Small', :last_name => 'User', :email => 'small@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 2, :check_date_time => DateTime.now,:confirmed_at => DateTime.now
user2.add_role :small

user3 = User.find_or_create_by_email :first_name => 'Large', :last_name => 'User', :email => 'large@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 3, :check_date_time => DateTime.now,:confirmed_at => DateTime.now
user3.add_role :large

ItemType.create(:name => 'Text')
ItemType.create(:name => 'File')
ItemType.create(:name => 'Image')

#
#MailTemplate.create(:name => 'Confirmation',:subject => '[Alert-System] Confirmation instruction', :body => '...')
#MailTemplate.create(:name => 'Reset Password',:subject => '[Alert-System] Reset password instruction', :body => '...')
#MailTemplate.create(:name => 'Validate',:subject => '[Alert-System] Are you still alive?', :body => '...')
#MailTemplate.create(:name => 'Disabled Account',:subject => '[Alert-System] Your account has been disabled?', :body => '...')
#MailTemplate.create(:name => 'Recipient',:subject => '[Alert-System] You have a package from someone?', :body => '...')
#MailTemplate.create(:name => 'Expire subscription',:subject => '[Alert-System] Your subscription has been expired !', :body => '...')


puts " Seed completed !"
