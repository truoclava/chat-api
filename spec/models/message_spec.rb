# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  sender_id       :integer
#  recipient_id    :integer
#  sent_at         :datetime
#  read_at         :datetime
#  read            :boolean          default(FALSE)
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  it "should set sent_at when message persisted" do
    message = build :message, sent_at: nil
    expect(message.sent_at).to be_nil
    message.save!
    expect(message.reload.sent_at).not_to be_nil
  end
end
