class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :favorites
  has_secure_password

  validates :display_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
