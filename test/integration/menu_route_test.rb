class MenuRouteTest < ActionDispatch::IntegrationTest
	def setup
		@site = create(:default_site)
		host! @site.host
		puts @site.host
		@content = create(:content, site: @site)
		@menu = create(:menu_with_items, site: @site, amount: 1, language: @site.default_language)
	end

	test 'should route to appropriate menu' do
		assert_routing '/de', {controller: 'odania/menu', action: 'menu_index', locale: 'de'}
		assert_routing '/en', {controller: 'odania/menu', action: 'menu_index', locale: 'en'}
	end

	test 'undefined locale should render 404' do
		assert_raises(ActionController::RoutingError) do
			get '/asd'
		end
	end
end
