class AddFlagToLanguage < ActiveRecord::Migration
	def change
		add_column :odania_languages, :flag_image, :string
	end
end
