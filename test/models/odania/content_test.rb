require 'test_helper'

module Odania
	class ContentTest < ActiveSupport::TestCase
		def setup
			@site = create(:default_site)
			@lang = create(:language)
			@user = create(:user)
		end

		test 'adding new tags' do
			assert_difference 'Odania::TagXref.count', 2 do
				content = Odania::Content.new(title: 'asd123', body: 'This is a body #T1 asdasdsa #T2',
														language_id: @lang.id, site_id: @site.id, user_id: @user.id)
				content.save!
			end
		end

		test 'removing tags' do
			content = Odania::Content.create(title: 'asd123', body: 'This is a body #T1 asdasdsa #T4 dasihdaius #T7',
													language_id: @lang.id, site_id: @site.id, user_id: @user.id)
			assert_difference 'Odania::TagXref.count', -1 do
				content.body = 'This is a body #T1 asdasdsa #T7'
				content.save!
			end
		end

		test 'adding new tags and removing old ones' do
			content = Odania::Content.create(title: 'asd123', body: 'This is a body #T1 asdasdsa #T4 dasihdaius #T7',
													language_id: @lang.id, site_id: @site.id, user_id: @user.id)
			assert_difference 'Odania::TagXref.count', 0 do
				content.body = 'This is a body #T1 asdasdsa #T8 lorem #T4 #T1'
				content.save!
			end
		end
	end
end
