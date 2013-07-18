# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  r = Random.new
  r.rand(1...10000)
  factory :user do
    first_name 'Test'
    last_name 'User'
    email "example#{r}@example.com"
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
    frequency 1
    status "validating"
    send_validate_mail_at DateTime.current - 24*3800   #make sure the time send validation
  end
  
end
