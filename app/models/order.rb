class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  attr_accessor :address_selection, :address_id
  enum payment_method: {credit: 0, bank: 1}
end