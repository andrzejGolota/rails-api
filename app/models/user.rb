class User < ApplicationRecord

  belongs_to :role

  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  LOGIN_REGEX = /\A(?=.*[A-Za-z0-9]$)[A-Za-z][A-Za-z\d_.-]{0,19}\z/

  def basic_user?
  end

  def premium_user?
  end

  def mod_user?
  end

  def admin_user?
  end

end
