class Api::V1::SessionsController < Api::ApiApplicationController
  before_action :ensure_authenticated_user, only: [:destroy]

  def create
    # http :3000/api/v1/login email=alex@stylelend.com password=password

    user = User.find_for_authentication(email: params[:email])
    if user && user.valid_password?(params[:password])
      access_token = login(user)
      sign_in(user)

      # Client expects user and token objects
      render json: {user: user, token: access_token}.to_json, status: :ok
    else
      render json: {message: "Incorrect email/password combination."}, status: :unauthorized
    end
  end

  def destroy
    access_token = AccessToken.find_by_token(token)
    access_token.destroy if access_token
    render json: {}, status: :ok
  end

end
