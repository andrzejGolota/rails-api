class Payment < ApplicationRecord
  include AASM

  belongs_to :order
  belongs_to :user

  validates_presence_of :state
  validates_presence_of :user_id
  validates_presence_of :order_id
  validates_presence_of :amount
  validate :completed_payment_blockade

  after_commit :create_payment_email, on: :create
  after_commit :cancel_pending_payments, on: :create

  aasm(:state) do
    state :pending, initial: true
    state :completed, :failed

    event :reject do
      transitions from: :pending, to: :completed#, after: Proc.new { |order| }
    end

    event :confirm do
      transitions from: :pending, to: :failed#, after: Proc.new { |order| }
    end
  end

  def create_payment_email

  end

  protected

  def cancel_pending_payments
    if self.order_id # it is quite useless as we call method after successful commit
      payments = self.order.pending_payments.where.not(id: self.id)
      payments.each{ |payment| payment.update_attribute(:state, 'failed') }
    end
  end

  def completed_payment_blockade
    if self.order_id
      errors[:order] << 'already has completed payment' if self.order.has_finalized_payment?
    end
  end

end
