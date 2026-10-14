class EnrollmentMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @member = user.member_profile

    mail(
      to: @user.email,
      subject: "Bienvenido al Club",
      body: "¡Bienvenido al Club, #{@member.first_name}!\n\nTu cuenta ya está activa. Tu número de socio es #{@member.member_number}."
    )
  end

  def confirmation(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @member = enrollment.member_profile

    mail(
      to: @member.user.email,
      subject: "Inscripción confirmada: #{@activity.name}",
      body: "Hola #{@member.first_name},\n\nTu inscripción a #{@activity.name} se registró correctamente.\nFecha de inicio: #{@enrollment.start_date.strftime('%d/%m/%Y')}."
    )
  end
end
