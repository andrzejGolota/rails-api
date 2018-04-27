class Role < ApplicationRecord
  has_many :users

  validates_presence_of :name
  validates :active, inclusion: { in: [true, false] }
  validates_uniqueness_of :name

  default_scope { where(active: true) }
end
