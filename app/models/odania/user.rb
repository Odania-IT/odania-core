class Odania::User < ActiveRecord::Base
	validates_length_of :name, minimum: 3, maximum: 20
	validates_uniqueness_of :name, :scope => [:site_id]
	validates_uniqueness_of :email, :scope => [:site_id]

	has_many :roles, class_name: 'Odania::UserRole'
	belongs_to :site, class_name: 'Odania::Site'
	belongs_to :language, class_name: 'Odania::Language'

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
