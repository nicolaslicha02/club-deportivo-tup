class Admin::BaseController < ApplicationController
  before_action :require_admin_login

  helper_method :current_admin

  def current_admin
    @current_admin ||= User.find_by(id: session[:admin_id]) if session[:admin_id]
  end

  private

  def require_admin_login
    unless current_admin && current_admin.admin?
      redirect_to admin_login_path, alert: "Debe iniciar sesión como administrador."
    end
  end
end
