class Contact < ApplicationRecord
  has_many :contact_addresses
  belongs_to :user

  accepts_nested_attributes_for :contact_addresses, allow_destroy: true

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :accepted, inclusion: { in: [true, false] }, if: Proc.new { |contact| contact.contact_user_id.present? }
  validates_presence_of :user_id
  before_validation :get_user_data

  scope :accepted_contacts, -> { where(accepted: true) }
  scope :awaiting_contacts, -> { where(accepted: false) }

  def default_address
    contact_addresses.where(default: true).first
  end

  private

  def get_user_data
    if self.contact_user_id
      user = User.find(self.contact_user_id)
      self.first_name = user.first_name if user.first_name?
      self.last_name = user.last_name if user.last_name?
    end
  end

  def check_user_type
    if self.user_id
      errors[:user_id] << " with premium status are allowed to create contacts" if !user.premium_priveleges?
    end
  end

end
