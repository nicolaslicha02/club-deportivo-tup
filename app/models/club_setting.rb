class ClubSetting < ApplicationRecord
  validates :base_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.current
    first || create(base_fee: 25000.0)
  end
end
