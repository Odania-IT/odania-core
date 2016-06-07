namespace :elasticsearch do
	desc 'Create or update indices'
	task :indices => :environment do
		require File.join(Rails.root, 'lib', 'elasticsearch_indices.rb')
		indices = ElasticsearchIndices.new
		indices.create_or_update
	end
end
