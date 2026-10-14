class Portal::ActivitiesController < ApplicationController
  def index
    # Solo ofrece actividades activas, con cupo y aún no elegidas por el socio.
    @available_activities = Activity.where(active: true).includes(:enrollments) - current_user.member_profile.activities
  end

  def enroll
    activity = Activity.find(params[:id])
    perfil = current_user.member_profile

    # Bloquea la actividad mientras verifica el cupo para evitar sobreinscripciones concurrentes.
    activity.with_lock do
      raise ActiveRecord::RecordInvalid.new(activity) unless activity.active? && activity.available_spots.positive?

      Enrollment.create!(member_profile: perfil, activity: activity, start_date: Date.current, active: true)
    end

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

    EnrollmentMailer.confirmation(perfil.enrollments.find_by!(activity: activity)).deliver_now
    redirect_to portal_dashboard_path, status: :see_other, notice: "Te inscribiste en #{activity.name}. Tu estado de cuenta fue actualizado."
  rescue ActiveRecord::RecordInvalid => error
    redirect_to portal_activities_path, status: :see_other, alert: error.record.errors.full_messages.to_sentence.presence || "La actividad ya no está disponible o no tiene cupos."
  end
end
