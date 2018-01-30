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

class Conversation < ActiveRecord::Base
  has_many :messages, -> { order(sent_at: :desc, id: :desc) }, inverse_of: :conversation, dependent: :destroy

  belongs_to :buyer, foreign_key: :buyer_id, class_name: "User"
  belongs_to :seller, foreign_key: :seller_id, class_name: "User"

  validates_presence_of :buyer, :seller

  accepts_nested_attributes_for :messages, reject_if: :all_blank

  scope :with_messages, -> { includes(:messages) }
  scope :order_last_activity_at, -> { order("last_activity_at desc nulls last") }

  scope :between, -> (seller_id,buyer_id) do
     where("(conversations.seller_id = ? AND conversations.buyer_id =?) OR (conversations.seller_id = ? AND conversations.buyer_id =?)", seller_id,buyer_id, buyer_id, seller_id)
   end

  before_create :set_last_activity_at

  def most_recent_message
    messages.first
  end

  private
    def set_last_activity_at
      self.last_activity_at = DateTime.current
    end
end
