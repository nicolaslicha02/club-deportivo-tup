class Admin::ClubSettingsController < Admin::BaseController
  def edit
    @setting = ClubSetting.current
  end

  def update
    @setting = ClubSetting.current
    if @setting.update(setting_params)
      redirect_to edit_admin_club_setting_path, notice: "Valor de la cuota base actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def setting_params
    params.require(:club_setting).permit(:base_fee)
  end
end
