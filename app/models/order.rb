class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products  
  has_many :payments

  validates_presence_of :state
  validates_presence_of :user_id
  validates_associated :payments

  after_commit :create_order_email, on: :create
  after_commit :finalize_order_email, if: proc { |order| order.completed? }
  after_commit :failure_order_email, if: proc { |order| order.failed? }

  aasm(:state) do
    state :new, initial: true
    state :failed, :completed

    event :failure do
      transitions from: :new, to: :failed
    end

    event :finalize do
      transitions from: :new, to: :completed, guard: :has_finalized_payment?
    end
  end

  def completed_payments
    payments.where(state: 'completed') 
  end

  def pending_payments
    payments.where(state: 'pending') 
  end

  def failed_payments
    payments.where(state: 'failed') 
  end

  def create_order_email

  end

  def finalize_order_email
  
  end

  def failure_order_email

  end

  def has_finalized_payment?
    has_finalized_payment
  end

  protected

  def has_finalized_payment
    !completed_payments.blank?
  end

end
