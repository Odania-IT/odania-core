class CreateOdaniaCoreSites < ActiveRecord::Migration
  def change
    create_table :odania_core_sites do |t|
      t.string :name
      t.string :host
      t.boolean :is_active
      t.boolean :is_default
      t.text :tracking_code
      t.text :description

      t.timestamps
    end
  end
end
