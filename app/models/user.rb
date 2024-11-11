class User < ApplicationRecord
  has_secure_password
  
  # Validating presence and confirmation of password
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  
  # Validating uniqueness of email, case insensitive
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validating presence of first name and last name
  validates :name, presence: true

  # Automatically downcase email before saving it to ensure case-insensitivity
  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end


  def self.authenticate_with_credentials(email, password)

    email = email.strip.downcase

    user = User.find_by(email: email)
    return user if user && user.authenticate(password)

    nil
  end
end