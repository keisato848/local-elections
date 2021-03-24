class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    authorization
  end

  def google_oauth2
    authorization
  end

  def twitter
    authorization
  end

  private

  def authorization
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authenticaction
    else
      render template: 'devise/registrations/new'
    end
  end
end
