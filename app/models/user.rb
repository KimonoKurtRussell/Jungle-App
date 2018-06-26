class User < ActiveRecord::Base

before_save :downcase

has_secure_password
has_many :reviews
has_many :orders

validates :name, presence: true
validates :email, presence: true, uniqueness: {case_sensitive: false}
validates :password, presence: true, confirmation: true, length: {minimum: 5}
validates :password_confirmation, presence: true


def authenticate_user(email, password)
  user = User.find_by_email(email.strip.downcase)
  if user && user.authenticate(password)
    return user
  else
    return nil
  end
end


def downcase
  self.email.downcase!
 end

end