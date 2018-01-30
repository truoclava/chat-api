FactoryGirl.define do
  factory :conversation do
    association :seller, factory: :user
    association :buyer, factory: :user

    transient do
      message_count 5
    end

    trait :with_messages do
      after :create do |convo, evaluator|
        evaluator.message_count.times do
          convo.messages << create(:message, sender: convo.seller_id, to: convo.buyer)
        end
      end
    end
  end
end
