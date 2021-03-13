class Order < ApplicationRecord
  
  belongs_to :customer
  has_many :order_details

  enum payment_method: {credit: 0, bank: 1}
end