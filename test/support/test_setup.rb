module OdaniaTestMock
	mattr_accessor :signed_in
	@@signed_in = false

	mattr_accessor :current_user
	mattr_accessor :user_authenticated
	@@user_authenticated = false

	def self.enqueue(background_type, opts)
		puts "Enqueued for background processing: #{background_type} with options: #{opts}"
	end
end

Odania.setup do |config|
	config.user_signed_in_function = 'OdaniaTestMock.signed_in'
	config.current_user_function = 'OdaniaTestMock.current_user'
	config.authenticate_user_function = 'OdaniaTestMock.user_authenticated'
	config.background_enqueue = 'OdaniaTestMock.enqueue'
end
