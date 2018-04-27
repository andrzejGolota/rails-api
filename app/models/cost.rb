class Cost < ApplicationRecord
  belongs_to :invoice
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :unit
  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :tax
  validates_presence_of :user_id
  validates_presence_of :invoice_id

  def total_price
    quantity*unit_price
  end

  def total_price_taxed
    quantity*(unit_price*tax+unit_price)
  end

end
