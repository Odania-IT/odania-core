class Odania::Content
	include Mongoid::Document
	include Mongoid::Timestamps

	field :title, type: String
	field :body, type: String
	field :body_short, type: String
	field :clicks, type: Integer, default: 0
	field :views, type: Integer, default: 0
	field :published_at, type: DateTime, default: Time.now
	field :is_active, type: Mongoid::Boolean

	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	belongs_to :user, :class_name => 'Odania::User'

	scope :active, -> { where(is_active: true) }

	validates_length_of :title, minimum: 1
	validates_length_of :body, minimum: 10
	validates_presence_of :language_id, :site_id, :user_id

	def to_param
		"#{self.id}-#{self.title.parameterize}"
	end

	before_save do
		self.is_active = (self.published_at <= Time.now)
		self.body_short = truncate_words(self.body, 50) if self.body_short.nil?

		return true
	end
end
