require 'rails_helper'

RSpec.describe Api::V1::ConversationsController, type: :controller do
  let(:buyer) { create :user }
  let(:seller) { create :user }

  describe 'POST #create' do
    let(:message_attributes) { [{sender_id: buyer.id, body: "Testing", recipient_id: seller.id}] }
    it "should create a conversation with the message" do
      expect {
        post :create, conversation: { buyer_id: buyer.id, seller_id: seller.id, message_attributes: message_attributes }, format: :json
      }.to change(Conversation, :count).by(1)

      convo = Conversation.last
      expect(convo.messages.count).to eq 1
      expect(convo.messages.first.body).to eq message_attributes.first[:body]
    end
  end

  describe 'POST #reply' do
    let!(:conversation) { create :conversation, buyer: buyer }

    it "should reply to the conversation" do
      expect {
        post :reply, id: conversation.id, message: {sender_id: conversation.buyer.id, body: "Testing", recipient_id: conversation.seller.id}, format: :json
      }.to change(Message, :count).by(1)

      expect(response).to have_http_status :created
      message = Message.last
      expect(message).not_to be_nil
      expect(message["conversation_id"]).to eq conversation.id
      expect(message["sender_id"]).to eq conversation.buyer_id
    end
  end
end
