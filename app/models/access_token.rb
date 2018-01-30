# == Schema Information
#
# Table name: access_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  scope      :string
#  expires_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class AccessToken < ActiveRecord::Base
  belongs_to :user

  before_create :generate_access_token, :set_expiration_date

  scope :session, -> { where(scope: 'session') }
  scope :api, -> { where(scope: 'api') }
  scope :active, -> { where('expires_at >= ?', Time.current) }

  def active?
    expires_at >= Time.current
  end

  def expired?
    !active?
  end

  private
    def set_expiration_date
      self.expires_at = if self.scope == 'session'
                          4.hours.from_now
                        else
                          1.year.from_now
                        end
    end

    def generate_access_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?(token: token)
    end
end
