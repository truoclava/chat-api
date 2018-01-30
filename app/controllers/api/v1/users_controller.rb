class Api::V1::UsersController < Api::ApiApplicationController
  def create
    user = User.new(permitted_params.user)
    user.password = params["password"]
    if user.save
      access_token = login(user, true)
      render json: {user: user, token: access_token}.to_json, status: :ok
    else
      render json: {errors: user.errors.full_messages}.to_json, status: :unprocessable_entity
    end
  end

  def index
    @per_page = 100
    @total_pages = (User.all.count/@per_page.to_f).ceil
    @page = params[:page] || 1
    @users = User.all.page(@page).per(@per_page).padding(params[:offset])
  end
end
