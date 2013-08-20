class User < ActiveRecord::Base
  attr_accessible :password, :user_name

  before_validation { |user| user.reset_session_token!(false) }

  validates(
    :password_digest,
    :session_token,
    :user_name,
    :presence => true
  )

  validates :user_name, :uniqueness => true

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)

    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end

  def is_pasword?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!(force = true)
    return unless self.session_token.nil? || force

    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end
end
