class ContactAddress < ApplicationRecord

  belongs_to :contact

  validates_presence_of :phone_number
  validates_presence_of :contact_id
  validates_uniqueness_of :default, scope: :contact_id
  validates :default,
            inclusion: { in: [true], message: "First address must be default!"},
            if: Proc.new { |ca| ContactAddress.where(contact_id: ca.contact_id, default: true).length < 1 }
  validates :default, inclusion: { in: [true, false] }

end
