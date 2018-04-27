class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products

  default_scope { where(active: true) }

  validates_presence_of :name
  validates :active, inclusion: { in: [true, false] }
  validates_presence_of :price
end
