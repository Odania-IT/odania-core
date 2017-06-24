class User
	include Mongoid::Document
	include Mongoid::Timestamps

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :confirmable,
			 :recoverable, :rememberable, :trackable, :validatable

	## Database authenticatable
	field :email, type: String, default: ''
	field :encrypted_password, type: String, default: ''

	## Recoverable
	field :reset_password_token, type: String
	field :reset_password_sent_at, type: Time

	## Rememberable
	field :remember_created_at, type: Time

	## Trackable
	field :sign_in_count, type: Integer, default: 0
	field :current_sign_in_at, type: Time
	field :last_sign_in_at, type: Time
	field :current_sign_in_ip, type: String
	field :last_sign_in_ip, type: String

	## Confirmable
	field :confirmation_token, type: String
	field :confirmed_at, type: Time
	field :confirmation_sent_at, type: Time
	field :unconfirmed_email, type: String

	## Lockable
	# field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,    type: String # Only if unlock strategy is :email or :both
	# field :locked_at,       type: Time

	field :name, type: String
	field :locale, type: String, default: 'de'
	field :terms_of_service, type: Mongoid::Boolean

	has_many :projects

	validates :name, uniqueness: {case_sensitive: false}, length: {minimum: 2}
	validates :terms_of_service, acceptance: true
end
