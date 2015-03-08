class Odania::Media < ActiveRecord::Base
	belongs_to :site, :class_name => 'Odania::Site'
	belongs_to :language, :class_name => 'Odania::Language'
	belongs_to :user, :class_name => 'Odania::User'

	has_attached_file :image, :styles => {:medium => '300x300>', :thumb => '100x100>'},
							default_url: '/images/defaults/media_:style.jpg'
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates_length_of :title, minimum: 1
	validates_presence_of :image
end
