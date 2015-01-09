class CreateClickTrackings < ActiveRecord::Migration
	def change
		create_table :odania_click_trackings do |t|
			t.references :obj, polymorphic: true
			t.datetime :view_date
			t.string :referer
			t.timestamps null: false
		end
	end
end
