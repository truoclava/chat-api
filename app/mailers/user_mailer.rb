class UserMailer < ApplicationMailer
  layout 'mailer'

  def new_message message
    @recipient = message.recipient
    @sender = message.sender
    @body = message.body

    mail(to: @recipient.email, subject: "You got a new message!")
  end
end
