class Portal::MembershipFeesController < ApplicationController
  def update
    fee = current_user.member_profile.membership_fees.find(params[:id])

    if fee.update(membership_fee_params)
      # Al subir el comprobante, marcamos la cuota como pagada (o pendiente de revisión)
      fee.update(status: "paid")
      redirect_to portal_dashboard_path, status: :see_other, notice: "Comprobante enviado exitosamente."
    else
      redirect_to portal_dashboard_path, status: :see_other, alert: "Debes adjuntar un archivo."
    end
  end

  private

  def membership_fee_params
    params.require(:membership_fee).permit(:receipt)
  end
end
