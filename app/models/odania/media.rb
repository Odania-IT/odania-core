class Odania::Media < ActiveRecord::Base
	has_attached_file :image, :styles => {:medium => '300x300>', :thumb => '100x100>'}, :default_url => '/images/:style/missing.png'
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates_length_of :title, minimum: 1
	validates_presence_of :image
end
