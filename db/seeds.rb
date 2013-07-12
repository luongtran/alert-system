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
#YAML.load(ENV['ROLES']).each do |role|
#  Role.find_or_create_by_name({:name => role}, :without_protection => true)
#  puts 'role: ' << role
#end
admin_role = Role.create(:name => 'admin')
free_role = Role.create(:name => 'free', :maximum_packages => 1, :unit_amount => 0)
small_role = Role.create(:name => 'small', :maximum_packages => 3, :unit_amount => 5)
medium_role = Role.create(:name => 'medium', :maximum_packages => 10, :unit_amount => 10)
large_role = Role.create(:name => 'large', :maximum_packages => 30, :unit_amount => 15)

user = User.find_or_create_by_email :first_name => 'Thanh', :last_name => 'Luan', :email => 'admin@gmail.com', :password => '123123', :password_confirmation => '123123', :frequency => 1000
user.add_role :admin

user2 = User.find_or_create_by_email :first_name => 'Free', :last_name => 'User', :email => 'free@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 1, :check_date_time => DateTime.now
user2.add_role :free

user3 = User.find_or_create_by_email :first_name => 'Small', :last_name => 'User', :email => 'small@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 2, :check_date_time => DateTime.now
user3.add_role :small

user5 = User.find_or_create_by_email :first_name => 'Large', :last_name => 'User', :email => 'large@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 3, :check_date_time => DateTime.now
user5.add_role :large


ItemType.create(:name => 'Text')
ItemType.create(:name => 'File')
ItemType.create(:name => 'Image')

puts " Seed completed !"
