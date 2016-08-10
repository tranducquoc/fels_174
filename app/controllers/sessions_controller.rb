class SessionsController < ApplicationController

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session_login user
      cookies_remember user
      respond_to do |format|
        format.json {render json: {result: I18n.t("login.success")}}
      end
    else
      respond_to do |format|
        format.json do
          render json: {
            result: I18n.t("login.failed"),
            message: I18n.t("login.message-error")
          }
        end
      end
    end
  end

  def destroy
    session_logout if logged_in?
    redirect_to root_path
  end
end
