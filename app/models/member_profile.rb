class MemberProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  has_many :membership_fees, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :activities, through: :enrollments

  enum :status, { active: 0, suspended: 1, cancelled: 2 }

  validates :first_name, :last_name, :birth_date, presence: true
  validates :dni, presence: true, uniqueness: true
  validates :member_number, presence: true, uniqueness: true

  # Genera el número automáticamente antes de validar
  before_validation :generate_member_number, on: :create

  private

  def generate_member_number
    return if member_number.present?


    ultimo_socio = MemberProfile.where("member_number LIKE 'SOC-%'").order(:member_number).last

    if ultimo_socio

      numero_limpio = ultimo_socio.member_number.gsub("SOC-", "").to_i
      siguiente_numero = (numero_limpio + 1).to_s.rjust(4, "0")
    else

      siguiente_numero = "0001"
    end

    self.member_number = "SOC-#{siguiente_numero}"
  end
end
