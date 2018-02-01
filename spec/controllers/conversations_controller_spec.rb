require 'rails_helper'

RSpec.describe Api::V1::ConversationsController, type: :controller do
  render_views

  let(:buyer) { create :user }
  let(:seller) { create :user }

  before do
    login(buyer)
  end

  describe 'POST #create' do
    let(:message_attributes) { {sender_id: buyer.id, body: "Testing", recipient_id: seller.id} }

    it "should create a conversation with the message" do
      expect {
        post :create, conversation: { buyer_id: buyer.id, seller_id: seller.id, message_attributes: message_attributes }, format: :json
      }.to change(Conversation, :count).by(1)

      convo = Conversation.last
      expect(convo.messages.count).to eq 1
      expect(convo.messages.first.body).to eq message_attributes[:body]
    end
  end

  describe 'GET #index' do
    let!(:convo1) { create :conversation, buyer: buyer, seller: seller }
    let!(:convo2) { create :conversation, buyer: buyer }
    let!(:convo3) { create :conversation, buyer: buyer }
    let!(:convo4) { create :conversation, buyer: seller }

    it "should return all conversations associated with buyer" do
      get :index, format: :json
      expect(response).to have_http_status :success
      expect(JSON.parse(response.body)["conversations"].length).to eq 3
    end
  end

  describe 'GET #messages' do
    let!(:convo) { create :conversation }

    before do
      create(:message, sender: convo.buyer, body: "test1", conversation: convo)
      create(:message, sender: convo.buyer, body: "test2", conversation: convo)
      create(:message, sender: convo.buyer, body: "test3", conversation: convo)
    end

    it "should return 3 messages" do
      get :messages, id: convo.id, page: 1, format: :json
      expect(response).to have_http_status :success
      expect(JSON.parse(response.body)["messages"].length).to eq 3
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
