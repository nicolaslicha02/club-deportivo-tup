class Portal::MembershipFeesController < ApplicationController
  def update
    fee = current_user.member_profile.membership_fees.find(params[:id])
    upload = membership_fee_params[:receipt]

    unless fee.pending? || fee.rejected?
      redirect_to portal_dashboard_path, status: :see_other, alert: "Esta cuota ya fue enviada y está pendiente de revisión."
      return
    end

    if upload.present? && fee.update(receipt: upload, status: :under_review, review_note: nil, reviewed_at: nil)
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
