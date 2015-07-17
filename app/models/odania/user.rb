class Odania::User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable,
			 :trackable, :validatable, :confirmable, :lockable, :omniauthable
	validates_length_of :name, minimum: 3, maximum: 20
	validates_uniqueness_of :name, :scope => [:site_id]
	validates_uniqueness_of :email, :scope => [:site_id]
	validate :name_not_eql_email

	has_many :roles, class_name: 'Odania::UserRole'
	belongs_to :site, class_name: 'Odania::Site', touch: true
	belongs_to :language, class_name: 'Odania::Language'
	has_many :devices, class_name: 'Odania::UserDevice'
	has_many :user_authentications, class_name: 'Odania::UserAuthentication'

	def name_not_eql_email
		errors.add('name', t('Name should not equal email')) if self.name.eql? self.email
	end

	def admin?
		role = self.roles.where(role: Odania::UserRole.roles[:admin]).first
		role.nil? ? false : true
	end

	before_create do
		language = Odania::Language.where(iso_639_1: I18n.locale.to_s).first
		language = Odania::Language.first if language.nil?
		self.language_id = language.id

		true
	end
end
