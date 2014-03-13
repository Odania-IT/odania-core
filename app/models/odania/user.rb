class Odania::User < ActiveRecord::Base
	validates_length_of :name, minimum: 3, maximum: 20
end
