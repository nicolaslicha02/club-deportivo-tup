class MembershipFee < ApplicationRecord
  require "json"

  belongs_to :member_profile

  enum :status, { pending: 0, under_review: 1, approved: 2, rejected: 3 }

  # Permite al socio subir su comprobante
  has_one_attached :receipt

  validates :review_note, presence: true, if: :rejected?
  validates :review_note, length: { maximum: 1000 }, allow_blank: true

  def fee_breakdown_items
    return JSON.parse(fee_breakdown) if fee_breakdown.present?

    # Cuotas anteriores a la incorporación del desglose conservan el total original.
    [ { "label" => "Cuota mensual del club", "amount" => amount.to_d.to_s } ]
  rescue JSON::ParserError
    [ { "label" => "Cuota mensual del club", "amount" => amount.to_d.to_s } ]
  end

  def recalculate_amount!
    items = build_fee_breakdown
    update!(amount: items.sum { |item| item.fetch("amount").to_d }, fee_breakdown: JSON.generate(items))
  end

  # Calcula el precio antes de crear la cuota
  before_create :calculate_dynamic_amount

  private

  def calculate_dynamic_amount
    items = build_fee_breakdown
    self.fee_breakdown = JSON.generate(items)
    self.amount = items.sum { |item| item.fetch("amount").to_d }
  end

  def build_fee_breakdown
    base_fee = ClubSetting.current.base_fee.to_d
    items = [ { "label" => "Cuota social mensual", "amount" => base_fee.to_s("F") } ]

    member_profile.activities.order(:name).each do |activity|
      items << { "label" => "Actividad: #{activity.name}", "amount" => activity.monthly_fee.to_d.to_s("F") }
    end

    items
  end
end
