class Invoice < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :client, class_name: "Company", foreign_key: 'client_id'
  belongs_to :company
  has_many :costs

  validates_presence_of :user_id
  validates_presence_of :client_id, unless: :is_draft?
  validates_presence_of :invoice_number, unless: :is_draft?
  validates_presence_of :subject, unless: :is_draft?
  validates_presence_of :company_id, unless: :is_draft?
  validates_presence_of :state
  validates_presence_of :settled_at, if: proc { |invoice| invoice.settled? }
  validate :settling_date

  before_save :set_settling_date, if: proc { |invoice| invoice.settled? || invoice.settled_at.blank? }

  accepts_nested_attributes_for :costs, allow_destroy: true

  aasm(:state) do
    state :created, initial: true
    state :pending, :settled, :draft

    event :fill do
      transitions from: :created, to: :pending
    end

    event :fill_draft do
      transitions from: :created, to: :draft
    end

    event :settle do
      transitions from: :pending, to: :settled
    end
  end

  def is_draft?
    draft?
  end

  def total_value
    costs.to_a.sum{ |cost| cost.quantity * cost.unit_price }
  end

  def total_taxed_value
    costs.to_a.sum{ |cost| cost.quantity * (cost.unit_price*cost.tax+cost.unit_price) }
  end

  protected
  
  def set_settling_date
    self.settled_at = Time.now
  end

  def settling_date
    if settled_at
      errors[:settled_at] << "Can't be future date" if settled_at > Time.now
      errors[:settled_at] << "Can't be older than creation date" if settled_at < created_at
    end
  end

end
