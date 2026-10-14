class Admin::MembershipFeesController < Admin::BaseController
  def index
    @fees = MembershipFee.includes(member_profile: :user).order(due_date: :asc)
    @status_counts = {
      all: MembershipFee.count,
      pending: MembershipFee.pending.count,
      under_review: MembershipFee.under_review.count,
      rejected: MembershipFee.rejected.count,
      approved: MembershipFee.approved.count
    }
    @fees = @fees.where(status: params[:status]) if MembershipFee.statuses.key?(params[:status])
  end

  def update
    @fee = MembershipFee.find(params[:id])

    unless @fee.under_review? && @fee.receipt.attached?
      redirect_to admin_membership_fees_path, status: :see_other, alert: "Solo se pueden revisar cuotas con comprobante enviado."
      return
    end

    attributes = case params[:decision]
    when "approve"
      { status: :approved, review_note: nil, reviewed_at: Time.current }
    when "reject"
      note = params[:review_note].to_s.strip
      if note.blank?
        redirect_to admin_membership_fees_path, status: :see_other, alert: "Indicá el motivo del rechazo para que el socio pueda corregir el comprobante."
        return
      end

      { status: :rejected, review_note: note, reviewed_at: Time.current }
    else
      redirect_to admin_membership_fees_path, status: :see_other, alert: "Elegí aprobar o rechazar el comprobante."
      return
    end

    if @fee.update(attributes)
      MembershipFeeMailer.review_result(@fee).deliver_now
      redirect_to admin_membership_fees_path, status: :see_other, notice: "La cuota quedó #{@fee.status == 'approved' ? 'aprobada' : 'rechazada'} y el socio fue notificado."
    else
      redirect_to admin_membership_fees_path, status: :see_other, alert: @fee.errors.full_messages.to_sentence
    end
  end
end
