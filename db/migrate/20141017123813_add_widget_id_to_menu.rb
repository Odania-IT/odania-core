class AddWidgetIdToMenu < ActiveRecord::Migration
	def change
		add_column :odania_menus, :widget_id, :integer, null: true
	end
end
