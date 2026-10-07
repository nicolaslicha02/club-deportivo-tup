class Admin::MemberProfilesController < Admin::BaseController
  def create
    @profile = MemberProfile.new(profile_params)
    # Asignamos un usuario base para el alta manual
    @profile.user = User.find_by(role: :member) || User.first

    if @profile.save
      redirect_to admin_root_path, notice: "Socio creado con su foto de perfil."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def index
    @profiles = MemberProfile.all
  end

  def new
  @profile = MemberProfile.new
end

  private

  def profile_params
    params.require(:member_profile).permit(:first_name, :last_name, :dni, :birth_date, :member_number, :avatar)
  end
end