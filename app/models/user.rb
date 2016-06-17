class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  has_one :profile
  has_one :hog_registration
  before_save :ensure_authentication_token
  validates :authentication_token, :uniqueness => true


end
