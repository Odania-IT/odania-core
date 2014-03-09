class OdaniaTestUser
	attr_accessor :admin_layout

	def initialize(layout=nil)
		self.admin_layout = layout
	end
end

module OdaniaTestMock
	mattr_accessor :signed_in
	@@signed_in = false

	mattr_accessor :current_user
	@@current_user = OdaniaTestUser.new

	mattr_accessor :user_authenticated
	@@user_authenticated = false

	def self.enqueue(background_type, opts)
		puts "Enqueued for background processing: #{background_type} with options: #{opts}"
	end
end

module UserAuthHelper
	def user_auth(opts)
		return redirect_to '/' unless user_signed_in?
	end
end

ActiveSupport.on_load(:action_controller) do
	include UserAuthHelper
end

Odania.setup do |config|
	config.user_signed_in_function = 'OdaniaTestMock.signed_in'
	config.current_user_function = 'OdaniaTestMock.current_user'
	config.authenticate_user_function = 'user_auth'
	config.background_enqueue = 'OdaniaTestMock.enqueue'
end
