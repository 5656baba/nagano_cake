class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :delivery_postal_code, presence: true
  validates :delivery_address, presence: true
  validates :delivery_name, presence: true
  validates :payment_method, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

  def delivery_full_address
    '〒' + delivery_postal_code + ' ' + delivery_address + ' ' + delivery_name
  end
end
