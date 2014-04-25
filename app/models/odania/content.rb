class Odania::Content < ActiveRecord::Base
	acts_as_taggable

	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	belongs_to :user, :class_name => 'Odania::User'
	belongs_to :menu_item, class_name: 'Odania::MenuItem'
	belongs_to :current_menu_item, class_name: 'Odania::MenuItem'

	scope :active, -> { where(is_active: true) }

	validates_length_of :title, minimum: 1
	validates_length_of :body, minimum: 10
	validates_presence_of :language_id, :site_id, :user_id

	def to_param
		"#{self.id}-#{self.title.parameterize}"
	end

	before_save do
		self.published_at = Time.now if self.published_at.nil?
		self.is_active = (self.published_at <= Time.now)
		self.tag_list, self.body_filtered = Odania::Filter.filter_html(self, self.body)
		self.body_short = Odania::TextHelper.truncate_words(self.body_filtered, 50) if self.body_short.nil? or self.body_short.blank?

		true
	end
end
