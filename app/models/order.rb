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

  scope :completed_payments, -> { payments.where(state: 'completed') }
  scope :pending_payments, -> { payments.where(state: 'pending') }
  scope :failed_payments, -> { payments.where(state: 'failed') }

  aasm(:state) do
    state :new, initial: true
    state :failed, :completed

    event :failure do
      transitions from: :new, to: :failed#, after: Proc.new { |order| }
    end

    event :finalize do
      transitions from: :new, to: :completed, guard: :has_finalized_payment?#, after: Proc.new { |order| }
    end
  end

  def create_order_email

  end

  protected

  def has_finalized_payment?
    !completed_payments.blank?
  end


end
