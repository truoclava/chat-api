FactoryGirl.define do
  factory :message do
    association :conversation
    association :sender, factory: :user
    association :recipient, factory: :user
    body "Message text"
    sent_at DateTime.current

    trait :read do
      read true
    end
  end
end
