class Country < ApplicationRecord
  has_many :companies, class_name: "Company", foreign_key: "country_code"

  validates :country_name, presence: true, uniqueness: true
  validates :iso_code, presence: true, uniqueness: true
  validates :active, presence: true, inclusion: { in: [true, false] }

  default_scope { where(active: true) }

end
