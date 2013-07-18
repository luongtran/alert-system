# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipient do
    
    email "luongtranduc@gmail.com"
    name "Luong Tran"
    address "test"
    phone_number "0988858049"
    
  end
end
