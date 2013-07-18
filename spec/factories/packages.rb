# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :package do
    name "test package"
    description "test package"
    encrypted_key Base64.encode64(OpenSSL::Cipher.new("AES-256-ECB").random_key)
    custom_key false
    recipient_id :recipient_id
    user {[FactoryGirl.create(:user)]}
    
  end
end
