class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Regenera el token cada vez que inicia sesión por seguridad
      user.regenerate_api_token
      render json: {
        status: "success",
        message: "Login exitoso",
        token: user.api_token
      }, status: :ok
    else
      render json: {
        status: "error",
        message: "Credenciales inválidas"
      }, status: :unauthorized
    end
  end
end
