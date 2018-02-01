class Api::ApiApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  protected
    def ensure_authenticated_user
      head :unauthorized unless api_current_user
    end

    def ensure_this_user sender_id=params[:conversation][:message_attributes][:sender_id]
      valid = api_current_user && (api_current_user.id == sender_id.try(:to_i))
      head :unauthorized unless valid
      valid
    end

    def login user, remember_me=false
      token = if remember_me
        user.access_tokens.api.create
      else
        user.access_tokens.session.create
      end

      user.update_tracked_fields!(warden.request)
      token
    end

    def api_current_user
      access_token = AccessToken.active.where(token: token).first
      access_token ? access_token.user : nil
    end

    def token
      bearer = request.headers["HTTP_AUTHORIZATION"]
      bearer ||= request.headers["rack.session"].try(:[], 'Authorization')
      bearer ? bearer.split.last : nil
    end
end
