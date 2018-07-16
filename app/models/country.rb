class Country < ApplicationRecord
  has_many :companies, class_name: 'Company', foreign_key: 'country_code'

  validates :country_name, presence: true, uniqueness: true
  validates :country_code, presence: true, uniqueness: true
  validates :active, inclusion: { in: [true, false] }

  default_scope { where(active: true) }
end
