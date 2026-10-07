class Admin::SessionsController < ApplicationController
  def new
    # Muestra el formulario
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password]) && user.admin?
      session[:admin_id] = user.id
      redirect_to admin_root_path, notice: "Sesión iniciada correctamente."
    else
      flash.now[:alert] = "Credenciales inválidas o sin permisos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_login_path, notice: "Sesión cerrada."
  end
end
