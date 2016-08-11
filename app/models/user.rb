class User < ActiveRecord::Base
  # Features
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  
  # Associations
  has_one :profile
  has_one :hog_registration
  has_many :test_rides
  has_many :my_bikes
  has_many :notifications, foreign_key: :recipient_id
  has_one :wishlist, :dependent => :destroy
  has_many :rides, through: :user_rides
  has_many :user_rides
  has_many :events, through: :user_events
  has_many :user_events
  has_many :my_docs
  has_one :notification_count

  # Validations
  validates :authentication_token, :uniqueness => true

  # Callbacks
  before_save :ensure_authentication_token
  after_create :create_profile_hog
  accepts_nested_attributes_for :profile
  after_create :create_wishlist

  def update_device_token(params)
    logger.info "=====Update TOken========="
    if params[:session].has_key?([:android_token])
      logger.info "==================Updated Users Android Token==========="
      self.update_attribute(:android_token, params[:session][:android_token])
    else params[:session].has_key?([:ios_token])
      logger.info "==================Updated Users IOS Token============"
      self.update_attribute(:ios_token, params[:session][:ios_token]
    end
  end  

	private

  def create_profile_hog
  	Profile.create( user_id: self.id, email: self.email )
  	HogRegistration.create( user_id: self.id, email: self.email )
  end

  def create_wishlist
    Wishlist.create(user_id: self.id)
  end

end