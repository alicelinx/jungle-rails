class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }

  # define class method with 'self.'
  def self.authenticate_with_credentials(email, password)
    user = find_by_email(email.downcase.strip) # to lower case and remove tailing/leading spaces
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
