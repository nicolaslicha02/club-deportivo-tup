class Enrollment < ApplicationRecord
  belongs_to :member_profile
  belongs_to :activity

  validates :start_date, presence: true
  validates :activity_id, uniqueness: { scope: :member_profile_id, message: "el socio ya está inscripto en esta actividad" }
  validate :activity_has_available_capacity, if: :new_record_or_activity_changed?

  private

  def new_record_or_activity_changed?
    new_record? || will_save_change_to_activity_id?
  end

  def activity_has_available_capacity
    return unless activity && activity.capacity.present? && activity.enrollments.count >= activity.capacity

    errors.add(:base, "La actividad no tiene cupos disponibles")
  end
end
