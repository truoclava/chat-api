module ApiHelpers
  # http://www.thegreatcodeadventure.com/better-rails-5-api-controller-tests-with-rspec-shared-examples/
  def login user=nil
    if user
      access_token = AccessToken.where(user_id: user.id).first || create(:access_token, user: user)
      controller.request.env['HTTP_AUTHORIZATION'] = access_token.token
    else
      expect(controller).to_receive(:ensure_authenticated_user).and_return(true)
    end
  end
end
