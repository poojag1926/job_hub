class User < ApplicationRecord
	has_many :professional_details, dependent: :destroy
  has_many :created_jobs,foreign_key: 'manager_id', class_name: 'Job' 
  has_many :applied_jobs, foreign_key: 'job_seeker_id'
  has_many :jobs, through: :applied_jobs
  has_one :company, foreign_key: 'owner_id'
	validates :username, presence: :true, uniqueness: {case_sensitive: false, message: 'can not be blank'}
	validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  mount_uploader :image, ImageUploader
  mount_uploader :resume, ResumeUploader

  scope :notifying_users, -> { where(email_updates: true)}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  USER_ROLES = %w(company_manager job_seeker)
  validates :contact_no, presence: :true, numericality: { only_integer: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         authentication_keys: [:login]
  devise :omniauthable, omniauth_providers: %i[facebook]
  accepts_nested_attributes_for :professional_details, reject_if: :all_blank, allow_destroy: true      
  attr_writer :login
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|     
      user.email = "#{auth.uid}_#{auth.provider}@gmail.com"
      user.password = Devise.friendly_token[0,20]
      user.full_name = auth.info.full_name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
      user.save(validate: false)
    end
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def is_manager?
    role.eql?('company_manager')
  end

  def is_job_seeker?
    role.eql?('job_seeker')
  end

  def company?
    is_manager? && company.present?
  end 

  def check_manager_login
     

  end
end




