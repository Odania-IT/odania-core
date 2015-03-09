class AddStateToContent < ActiveRecord::Migration
	def change
		add_column :odania_contents, :state, :integer
	end
end
