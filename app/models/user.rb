class User < ActiveRecord::Base
  attr_accessible :password, :user_name

  before_validation { |record| record.reset_session_token!(false) }

  validates(
    :password,
    :session_token,
    :user_name,
    :presence => true
  )

  def reset_session_token!(force = true)
    return unless self.session_token.nil? || force

    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
  end
end
