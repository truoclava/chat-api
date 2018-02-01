# == Schema Information
#
# Table name: conversations
#
#  id               :integer          not null, primary key
#  seller_id        :integer
#  buyer_id         :integer
#  last_activity_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe '#last_activity_at' do
    it "should be set when conversation is created" do
      conversation = create :conversation
      expect(conversation.last_activity_at).not_to be_nil
    end

    it "should set last_activity_at when a message is created" do
      conversation = build :conversation
      expect(conversation.last_activity_at).to be_nil
      conversation.messages << create(:message, conversation: conversation, sender: conversation.buyer)
      expect(conversation.last_activity_at).not_to be_nil
    end
  end

  describe '#most_recent_message' do
    it "should return the last message in conversation" do
      conversation = create :conversation
      expect(conversation.most_recent_message).to be_nil
      conversation.messages << create(:message, conversation: conversation, sender: conversation.buyer)
      expect(conversation.most_recent_message).not_to be_nil
    end
  end
end
