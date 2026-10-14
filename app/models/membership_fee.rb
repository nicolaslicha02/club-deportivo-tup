class MembershipFee < ApplicationRecord
  belongs_to :member_profile

  enum :status, { pending: 0, under_review: 1, approved: 2, rejected: 3 }

  # Permite al socio subir su comprobante
  has_one_attached :receipt

  validates :review_note, presence: true, if: :rejected?
  validates :review_note, length: { maximum: 1000 }, allow_blank: true

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
