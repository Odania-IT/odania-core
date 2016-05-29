require 'rails_helper'

RSpec.describe TemplateController, :type => :controller do
	before do
		global_cfg = JSON.parse File.read("#{Rails.root}/spec/fixtures/global_config.json")

		$consul_mock.service.services = {
			'odania_static' => [
				OpenStruct.new({
										'Node' => 'agent-one',
										'Address' => '172.20.20.1',
										'ServiceID' => 'odania_static_1',
										'ServiceName' => 'odania_static',
										'ServiceTags' => [],
										'ServicePort' => 80,
										'ServiceAddress' => '172.20.20.1'
									}),
				OpenStruct.new({
										'Node' => 'agent-two',
										'Address' => '172.20.20.2',
										'ServiceID' => 'odania_static_2',
										'ServiceName' => 'odania_static',
										'ServiceTags' => [],
										'ServicePort' => 80,
										'ServiceAddress' => '172.20.20.1'
									})
			]
		}

		$consul_mock.config.set('global_plugins_config', global_cfg)

		allow_any_instance_of(TemplateController).to receive(:get_from_internal_proxy) do
			'This is our test template!!!'
		end
	end

	describe 'GET page' do
		it 'returns http success' do
			get :page, params: {req_host: 'www.example.com', domain: 'example.com', group_name: 'odania-static', req_url: '/example/url.html'}
			expect(response).to have_http_status(:success)
		end
	end

	describe 'GET partial' do
		it 'returns http success' do
			get :partial, params: {req_host: 'www.example.com', domain: 'example.com', group_name: 'odania-static', plugin_url: '/example/url.html', partial_name: 'my-partial'}
			expect(response).to have_http_status(:success)
		end
	end

end
