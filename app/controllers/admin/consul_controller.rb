class Admin::ConsulController < AdminController
	def index
		@services = Odania.plugin.get_all

		logger.info @services
	end

	def service
		name = params['name'].to_s
		service = Odania.plugin.config_for(name)

		render json: service
	end

	def status
		Odania.plugin.health.state
	end
end
