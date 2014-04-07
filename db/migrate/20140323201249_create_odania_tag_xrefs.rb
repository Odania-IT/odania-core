class CreateOdaniaTagXrefs < ActiveRecord::Migration
	def change
		create_table :odania_tag_xrefs do |t|
			t.integer :tag_id
			t.string :ref_type
			t.integer :ref_id
			t.string :context, :limit => 128
		end

		add_index :odania_tag_xrefs, [:tag_id, :context]
		add_index :odania_tag_xrefs, [:ref_type, :ref_id, :context]
	end
end
