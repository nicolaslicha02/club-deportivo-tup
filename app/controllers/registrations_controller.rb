class RegistrationsController < ApplicationController
  def new
    @user = User.new
    # Prepara el espacio en memoria para los datos del perfil
    @user.build_member_profile
  end

  def create
    @user = User.new(user_params)
    @user.role = 1 # Rol de socio

    if @user.save
      # NUEVO: Generar la primera cuota (cobro base) apenas se asocia
      MembershipFee.create!(
        member_profile: @user.member_profile,
        due_date: Date.today.end_of_month,
        status: "pending"
      )

      session[:user_id] = @user.id
      redirect_to portal_dashboard_path, status: :see_other, notice: "¡Cuenta creada con éxito! Bienvenido al Club."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      member_profile_attributes: [ :first_name, :last_name, :dni, :birth_date, :avatar ]
    )
  end
end
