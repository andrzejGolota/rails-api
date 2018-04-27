class Message < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :recipent, class_name: "User", foreign_key: 'recipent_id'

  validates_presence_of :user_id
  validates_presence_of :recipent_id
  validates_presence_of :content
  validates_presence_of :state
  validates_presence_of :received_at, if: Proc.new { |message| message.received? }
  validate :receiving_date
  # validates :attachment,
  #   :file_size => {
  #     :maximum => 5.megabytes.to_i
  #   }


  aasm(:state) do
    state :sent, initial: true
    state :received

    event :read do
      transitions from: :sent, to: :received
    end
  end

  protected

  def receiving_date
    if self.received_at?
      errors[:received_at] << "Can't be future date" if self.received_at > DateTime.now
      errors[:received_at] << "Can't be older than sent date" if self.received_at < self.created_at
    end
  end

end
