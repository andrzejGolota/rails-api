class Payment < ApplicationRecord
  include AASM

  belongs_to :order
  belongs_to :user

  validates_presence_of :state
  validates_presence_of :user_id
  validates_presence_of :order_id
  validates_presence_of :amount
  validate :completed_payment_blockade

  after_create :create_payment_email
  after_create :cancel_pending_payments
  after_commit :rejected_payment_email, if: proc { |p| p.failed? }
  after_commit :completed_payment_email, if: proc { |p| p.completed? }

  aasm(:state) do
    state :pending, initial: true
    state :completed, :failed

    event :confirm do
      transitions from: :pending, to: :completed, guard: :has_paypal_id?
    end

    event :reject do
      transitions from: :pending, to: :failed
    end
  end

  def create_payment_email

  end

  def rejected_payment_email

  end

  def completed_payment_email

  end

  protected

  def has_paypal_id?
    self.paypal_id.present?
  end

  def cancel_pending_payments
    order.pending_payments.each{ |payment| payment.id != id && payment.reject! } if order_id
  end

  def completed_payment_blockade
    if order_id
      errors[:order] << 'already has completed payment' if order.has_finalized_payment?
    end
  end

end
