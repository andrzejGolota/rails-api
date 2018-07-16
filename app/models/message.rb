class Message < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :recipent, class_name: "User", foreign_key: 'recipent_id'

  validates_presence_of :user_id
  validates_presence_of :recipent_id
  validates_presence_of :content
  validates_presence_of :state
  validates_presence_of :received_at, if: proc { |message| message.received? }
  validate :receiving_date
  # validates :attachment,
  #   :file_size => {
  #     :maximum => 5.megabytes.to_i
  #   }
  
  before_save :set_messages_to_received, if: proc { |message| message.received? }
  #before_save :set_receiving_date, if: proc { |message| message.received? }

  aasm(:state) do
    state :sent, initial: true
    state :received

    event :read do
      transitions from: :sent, to: :received
    end
  end

  private
  #TODO callback doesnt work
  def set_messages_to_received
    unless user.sent_messages.blank?  
      Message.where(user_id: user_id, state: 'sent', recipent_id: recipent_id).each do |m|
        m.received_at = Time.now
        m.state = 'received'
        Rails.logger.debug "--DEBUG"
        Rails.logger.debug "#{m.save}"
        m.save!
      end
    end
  end

  def set_receiving_date
    self.received_at = Time.now
  end

  def receiving_date
    if received_at
      errors[:received_at] << "Can't be future date" if received_at > Time.now
      errors[:received_at] << "Can't be older than sent date" if received_at < created_at
    end
  end

end
