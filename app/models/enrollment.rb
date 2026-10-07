class Enrollment < ApplicationRecord
  belongs_to :member_profile
  belongs_to :activity

  validates :start_date, presence: true
  validates :activity_id, uniqueness: { scope: :member_profile_id, message: "el socio ya está inscripto en esta actividad" }
end
