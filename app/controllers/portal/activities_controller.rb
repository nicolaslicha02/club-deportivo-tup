class Portal::ActivitiesController < ApplicationController
  def index
    # Muestra las actividades activas en las que el socio aún no está inscripto
    @available_activities = Activity.where(active: true) - current_user.member_profile.activities
  end

  def enroll
    activity = Activity.find(params[:id])
    perfil = current_user.member_profile

    # 1. Inscribir al socio en la actividad
    Enrollment.create!(
      member_profile: perfil,
      activity: activity,
      start_date: Date.today
    )

    # 2. Lógica de facturación
    cuota_pendiente = perfil.membership_fees.find_by(status: "pending")

    if cuota_pendiente
      # Si ya tiene una cuota sin pagar, recalcula el total (Base + Todas sus actividades)
      nuevo_total = ClubSetting.current.base_fee + perfil.activities.sum(:monthly_fee)
      cuota_pendiente.update(amount: nuevo_total)
    else
      # Si estaba al día, le genera una nueva cuota para el mes actual
      MembershipFee.create!(
        member_profile: perfil,
        due_date: Date.today.end_of_month,
        status: "pending"
      )
    end

    redirect_to portal_dashboard_path, status: :see_other, notice: "Te inscribiste en #{activity.name}. Tu estado de cuenta fue actualizado."
  end
end
