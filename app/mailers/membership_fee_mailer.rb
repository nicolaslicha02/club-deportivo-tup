class MembershipFeeMailer < ApplicationMailer
  def review_result(fee)
    @fee = fee
    @member = fee.member_profile
    result = fee.approved? ? "aprobada" : "rechazada"
    message = "Hola #{@member.first_name},\n\nLa revisión de tu comprobante para la cuota de #{@fee.due_date&.strftime('%m/%Y')} terminó: la cuota fue #{result}."
    message += "\n\nMotivo: #{@fee.review_note}" if fee.rejected?

    mail(to: @member.user.email, subject: "Comprobante de cuota #{result}", body: message)
  end
end
