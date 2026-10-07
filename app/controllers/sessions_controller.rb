class SessionsController < ApplicationController
  def new
    # Renderiza el formulario
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      # Redirección inteligente según el rol
      if user.admin?
        redirect_to admin_root_path, status: :see_other, notice: "Bienvenido al panel de administración."
      else
        redirect_to portal_dashboard_path, status: :see_other, notice: "Sesión iniciada correctamente."
      end
    else
      flash.now[:alert] = "Correo o contraseña incorrectos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, status: :see_other, notice: "Has cerrado sesión exitosamente."
  end
end
