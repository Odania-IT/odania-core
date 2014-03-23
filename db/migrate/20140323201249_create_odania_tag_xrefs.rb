class CreateOdaniaTagXrefs < ActiveRecord::Migration
	def change
		create_table :tag_xrefs do |t|
			t.integer :tag_id
			t.string :ref_type
			t.integer :ref_id
		end
	end
end
