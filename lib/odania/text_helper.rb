require 'sanitize'

module Odania
	module TextHelper
		class << self
			# Returns a string that has a max of length words. Tags are stripped first
			def truncate_words(text, length = 30, end_string = '...')
				return '' if text.blank?
				words = Sanitize.clean(text, Sanitize::Config::RESTRICTED).split()
				(words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')).html_safe
			end
		end
	end
end
