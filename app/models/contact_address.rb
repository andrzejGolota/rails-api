class ContactAddress < ApplicationRecord
  belongs_to :contact

  validates_presence_of :phone_number
  validates_presence_of :contact_id
  validates :default,
            inclusion: { in: [true], message: "address is not added, so the first one must be default!"},
            if: proc { |ca| ContactAddress.where(contact_id: ca.contact_id, default: true).empty? }
  validates :default, inclusion: { in: [true, false] }

  before_validation :set_new_default_address

  private

  def set_new_default_address
    contact_addresses = ContactAddress.where(contact_id: contact_id, default: true)
    if !contact_addresses.empty? && default
      contact_addresses.update_all default: false
    elsif contact_addresses.empty? && !default
      self.default = true
    end
  end

end
