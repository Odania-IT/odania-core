class AddFieldsToUser < ActiveRecord::Migration
	def change
		add_column :odania_users, :terms_accepted, :datetime
		add_column :odania_users, :ref_id, :integer
		add_column :odania_users, :tracking, :text
		add_column :odania_users, :newsletter, :boolean
	end
end
