class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_token

  enum :role, { admin: 0, member: 1 }

  has_one :member_profile, dependent: :destroy
  accepts_nested_attributes_for :member_profile

  validates :email, presence: true, uniqueness: true
end
