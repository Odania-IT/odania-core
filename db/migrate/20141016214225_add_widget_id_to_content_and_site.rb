class AddWidgetIdToContentAndSite < ActiveRecord::Migration
	def change
		add_column :odania_contents, :widget_id, :integer, null: true
		add_column :odania_sites, :default_widget_id, :integer, null: true
	end
end
