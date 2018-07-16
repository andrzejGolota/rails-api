class User < ApplicationRecord
  has_many :invoices
  has_many :orders
  has_many :payments, through: :orders
  has_many :companies
  has_many :costs, through: :invoices
  has_many :sent_messages, class_name: "Message", foreign_key: 'user_id'
  has_many :received_messages, class_name: "Message", foreign_key: 'recipent_id'
  has_many :contacts
  belongs_to :role

  has_secure_password

  attr_accessor :remember_token, :activation_token, :reset_token

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  LOGIN_REGEX = /\A(?=.*[A-Za-z0-9]$)[A-Za-z][A-Za-z\d_.-]{0,19}\z/

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, presence: true,
            format: { with: EMAIL_REGEX, message: "incorrect format" },
            uniqueness: { case_sensitive: false }, length: { minimum: 6, maximum: 30 }
  validates :login,
            presence: true,
            format: { with: LOGIN_REGEX, message: "incorrect format" },
            exclusion: { in: %w(admin root) },
            uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :password_digest, presence: true, length: { minimum: 8, maximum: 30 }
  validates :is_active, inclusion: { in: [true, false] }
  validates_presence_of :activation_sent_date
  validates_presence_of :contact_visibility
  validates_presence_of :role_id
  # validates :avatar, :file_size => {
  #   :maximum => 5.megabytes.to_i
  # }

  before_save :downcase_attributes
  before_create :create_activation_digest
  after_create :send_activation_email 

  def basic_user?
    role.name == "Invoice-App-FreeUser"
  end

  def premium_user?
    role.name == "Invoice-App-PremiumUser"
  end

  def mod_user?
    role.name == "Invoice-App-Mod"
  end

  def admin_user?
    role.name == "Invoice-App-HeadAdmin"
  end

  def premium_priveleges?
    premium_user? || mod_user? || admin_user?
  end

  def products
    orders.includes(:products)
  end

  def remember
    remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    digest.nil? ? false : BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def reset_password
    create_reset_digest
    send_reset_email
  end

  def activate
    update_columns(is_active: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    #UserMailer.delay.account_activation(self.id)
    update_attribute(:activation_sent_date, Time.zone.now)
  end

  def send_reset_email
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_date: Time.zone.now)
  end

  def accepted_contacts
    contacts.where(contacts: { accepted: true } ) unless contacts.empty?
  end

  def awaiting_contacts
    contacts.where(contacts: { accepted: false } ) unless contacts.empty?
  end

  def conversation_with recipent_id
    sent_messages.where(messages: { recipent_id: recipent_id })
                 .or(received_messages.where(messages: { user_id: recipent_id }))
                 .order(created_at: :asc)
  end

  private

  def downcase_attributes
    email.downcase!
    login.downcase!
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
