class Company < ApplicationRecord

  belongs_to :user
  has_many :received_invoices, class_name: "Invoice", foreign_key: "client_id"
  has_many :issued_invoices, class_name: "Invoice", foreign_key: "company_id"
  belongs_to :country, class_name: "Country", foreign_key: "country_code"

  validates :company_number, uniqueness: true, presence: true
  validates :vat_number, uniqueness: true, presence: true
  validates_presence_of :street
  validates_presence_of :postcode
  validates_presence_of :city
  validates_presence_of :country_code
  validates_presence_of :user_id
  validates_presence_of :name

end
