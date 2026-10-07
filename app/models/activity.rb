class Activity < ApplicationRecord
  has_many :enrollments, dependent: :restrict_with_error
  has_many :member_profiles, through: :enrollments

  validates :name, presence: true, uniqueness: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :monthly_fee, numericality: { greater_than_or_equal_to: 0 }
end
