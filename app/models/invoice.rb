class Invoice < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :client, class_name: "Company", foreign_key: 'client_id'
  belongs_to :company
  has_many :costs

  validates_presence_of :user
  validates_presence_of :client, unless: :is_draft?
  validates_presence_of :invoice_number, unless: :is_draft?
  validates_presence_of :subject, unless: :is_draft?
  validates_presence_of :company_id, unless: :is_draft?
  validates_presence_of :state
  validates_presence_of :settled_at, if: Proc.new { |invoice| invoice.settled? }
  validate :settling_date

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
    cost_sum = 0
    costs.each{ |cost| cost_sum = cost_sum + cost.quantity*cost.unit_price }
  end

  def total_taxed_value
    cost_sum = 0
    costs.each{ |cost| cost_sum = cost_sum + cost.quantity*(cost.unit_price*cost.tax+cost.unit_price) }
  end

  protected

  def settling_date
    if self.settled_at
      errors[:settled_at] << "Can't be future date" if self.settled_at > DateTime.now
      errors[:settled_at] << "Can't be older than creation date" if self.settled_at < self.created_at
    end
  end

end
