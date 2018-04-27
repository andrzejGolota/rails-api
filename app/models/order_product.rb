class OrderProduct < ApplicationRecord
  belongs_to :product, dependent: :destroy
  belongs_to :order, dependent: :destroy

  validates_presence_of :product_id
  validates_presence_of :order_id 
end
