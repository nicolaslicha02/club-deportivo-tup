class MembershipFee < ApplicationRecord
  belongs_to :member_profile

  # Permite al socio subir su comprobante
  has_one_attached :receipt

  # Calcula el precio antes de crear la cuota
  before_create :calculate_dynamic_amount

  private

  def calculate_dynamic_amount
    # Lee el valor dinámico configurado por el admin
    cuota_base = ClubSetting.current.base_fee

    # Suma el costo mensual de actividades
    costo_actividades = member_profile.activities.sum(:monthly_fee)

    self.amount = cuota_base + costo_actividades
  end
end
