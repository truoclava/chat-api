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

require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
