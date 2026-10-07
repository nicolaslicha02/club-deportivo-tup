class Admin::MembershipFeesController < ApplicationController
  def index
    @fees = MembershipFee.includes(member_profile: :user).order(due_date: :asc)
  end

  def update
    @fee = MembershipFee.find(params[:id])

    # Mapeamos explícitamente el texto del botón al valor del enum de la base de datos
    nuevo_estado = case params[:status]
    when "approved" then 2
    when "paid" then 1
    else 0 # 'pending'
    end

    if @fee.update(status: nuevo_estado)
      redirect_to admin_membership_fees_path, status: :see_other, notice: "Estado de la cuota actualizado correctamente."
    else
      redirect_to admin_membership_fees_path, status: :see_other, alert: "Hubo un error al actualizar la cuota."
    end
  end
end
