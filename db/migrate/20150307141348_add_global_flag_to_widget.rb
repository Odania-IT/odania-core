class AddGlobalFlagToWidget < ActiveRecord::Migration
	def change
		add_column :odania_widgets, :is_global, :boolean, default: false
	end
end
