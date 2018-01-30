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

class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  validates_presence_of :body, :conversation, :sender, :sent_at, :recipient

  before_validation :set_sent_at, on: :create
  before_create :touch_conversation
  # after_create :send_email_notifcation

  private
    def touch_conversation
      conversation.touch :last_activity_at if conversation.present?
    end

    def set_sent_at
      if sent_at.nil?
        self.sent_at = DateTime.current
      end
    end

    def send_email_notifcation
      # UserMailer.new_message(self).deliver_now
      # UserMailer.new_message(self).deliver_later(wait: 5.minutes)
    end
end
