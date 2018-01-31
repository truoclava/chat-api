class Api::V1::ConversationsController < Api::ApiApplicationController
  def create
    # http :3000/api/v1/conversations conversation:='{"seller_id": 1, "buyer_id": 2}'
    if Conversation.between(permitted_params.conversation[:seller_id], permitted_params.conversation[:buyer_id]).present?
       @conversation = Conversation.between(permitted_params.conversation[:seller_id], permitted_params.conversation[:buyer_id]).first

       if permitted_params.conversation[:message_attributes]
         @conversation.messages.build(permitted_params.conversation["message_attributes"])
       end

    else
      @conversation = Conversation.new(buyer_id: permitted_params.conversation[:buyer_id], seller_id: permitted_params.conversation[:seller_id])
      @conversation.messages.build(permitted_params.conversation["message_attributes"])
    end

    @conversation.save
  end

  def index
    # http :3000/api/v1/conversations
    @conversations = current_user ? Conversation.where("seller_id = ? or buyer_id =?", current_user.id, current_user.id) : []

    # render json: {conversations: @conversations}, status: :ok
  end

  def messages
    # http :3000//api/v1/conversations/1/messages
    conversation = Conversation.find(params[:id])
    @per_page = 10
    @total_pages = (conversation.messages.count/@per_page.to_f).ceil
    @page = params[:page] || 1
    @messages = conversation.messages.page(@page).per(@per_page).padding(params[:offset])
    render json: {messages: @messages}, status: :ok
  end

  def reply
    # http :3000/api/v1/conversations/1/reply message:='{"sender_id": 1, "recipient_id": 2, "body": "Test Reply"}'
    conversation = Conversation.find(params[:id])

    # also can use current_user, probably best practice. need to run more tests to confirm devise is working
    sender = User.find(permitted_params.message["sender_id"]) || current_user
    recipient = (conversation.buyer == sender ? conversation.seller : conversation.buyer);
    message = conversation.messages.build(sender: sender, recipient: recipient, body: permitted_params.message[:body], sent_at: DateTime.current)
    if message.save
      render json: {message: message}, status: :created
    else
      render json: {errors: message.errors.full_messages}, status: :unprocessable_entity
    end
  end

end
