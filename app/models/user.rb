class User < ActiveRecord::Base
  # Features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  
  # Associations
  has_one :profile
  has_one :hog_registration

  # Validations
  validates :authentication_token, :uniqueness => true

  # Callbacks
  before_save :ensure_authentication_token
  after_create :create_profile_hog
  accepts_nested_attributes_for :profile


	private

  def create_profile_hog
  	Profile.create( user_id: self.id, email: self.email )
  	HogRegistration.create( user_id: self.id, email: self.email )
  end

end