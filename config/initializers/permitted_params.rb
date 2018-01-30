PermittedParams.setup do |config|
  config.user do
    scalar :password, :email, :name, :password_confirmation
  end

  config.conversation do
    scalar :seller_id, :buyer_id
    nested :message
  end

  config.message do
    scalar :sender_id, :body, :read, :sent_at, :recipient_id
  end
end
