class AddForeignKeys < ActiveRecord::Migration
	def change
		# Tags
		add_foreign_key :odania_tag_xrefs, :odania_tags, column: :tag_id
		add_foreign_key :odania_tags, :odania_sites, column: :site_id
		add_foreign_key :odania_tags, :odania_languages, column: :language_id

		# Content
		add_foreign_key :odania_contents, :odania_sites, column: :site_id
		add_foreign_key :odania_contents, :odania_languages, column: :language_id
		add_foreign_key :odania_contents, :odania_users, column: :user_id
		add_foreign_key :odania_contents, :odania_menu_items, column: :menu_item_id
		add_foreign_key :odania_contents, :odania_menu_items, column: :current_menu_item_id
		add_foreign_key :odania_contents, :odania_widgets, column: :widget_id
		add_foreign_key :odania_contents, :odania_categories, column: :category_id

		# Category
		add_foreign_key :odania_categories, :odania_sites, column: :site_id
		add_foreign_key :odania_categories, :odania_languages, column: :language_id
		add_foreign_key :odania_categories, :odania_users, column: :user_id

		# Media
		add_foreign_key :odania_media, :odania_sites, column: :site_id
		add_foreign_key :odania_media, :odania_languages, column: :language_id
		add_foreign_key :odania_media, :odania_users, column: :user_id

		# Menu
		add_foreign_key :odania_menus, :odania_sites, column: :site_id
		add_foreign_key :odania_menus, :odania_languages, column: :language_id
		add_foreign_key :odania_menus, :odania_menu_items, column: :default_menu_item_id

		# Menu Item
		add_foreign_key :odania_menu_items, :odania_menu_items, column: :parent
		add_foreign_key :odania_menu_items, :odania_menus, column: :menu_id

		# Site
		add_foreign_key :odania_sites, :odania_languages, column: :default_language_id
		add_foreign_key :odania_sites, :odania_sites, column: :redirect_to_id
		add_foreign_key :odania_sites, :odania_widgets, column: :default_widget_id
		add_foreign_key :odania_sites, :odania_static_pages, column: :imprint_id
		add_foreign_key :odania_sites, :odania_static_pages, column: :terms_and_conditions_id

		# Static Page
		add_foreign_key :odania_static_pages, :odania_languages, column: :default_language_id
		add_foreign_key :odania_static_pages, :odania_sites, column: :redirect_to_id
		add_foreign_key :odania_static_pages, :odania_users, column: :user_id
		add_foreign_key :odania_static_pages, :odania_widgets, column: :widget_id

		# User
		add_foreign_key :odania_users, :odania_sites, column: :site_id
		add_foreign_key :odania_users, :odania_languages, column: :language_id

		# User Role
		add_foreign_key :odania_user_roles, :odania_users, column: :user_id

		# Widget
		add_foreign_key :odania_widgets, :odania_sites, column: :site_id
		add_foreign_key :odania_widgets, :odania_languages, column: :language_id
		add_foreign_key :odania_widgets, :odania_users, column: :user_id
	end
end
