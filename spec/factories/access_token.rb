FactoryGirl.define do
  factory :access_token do
    association :user
    scope 'api'
  end
end
