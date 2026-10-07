class ApplicationController < ActionController::Base
  # Esto hace que el método también se pueda usar en las vistas (HTML)
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
