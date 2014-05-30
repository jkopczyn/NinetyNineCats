class User < ActiveRecord::Base
  attr_reader :password

  has_many :cats

  before_validation :ensure_session_token

  validates :password_digest, :presence => true
  validates(
    :password,
    :length => { :minimum => 6, :allow_nil => true }
  )
  validates :session_token, :presence => true, :uniqueness => true
  validates :user_name, :presence => true, :uniqueness => true

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)

    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def is_password?(unencrypted_password)
    BCrypt::Password
      .new(self.password_digest)
      .is_password?(unencrypted_password)
  end

  def owns_cat?(cat)
    cat.user_id == self.id
  end

  def password=(unencrypted_password)
    # BCrypt will happily encrypt an empty string
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest =
        BCrypt::Password.create(unencrypted_password)
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end

