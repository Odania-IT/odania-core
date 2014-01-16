class CreateOdaniaCoreLanguages < ActiveRecord::Migration
  def change
    create_table :odania_core_languages do |t|
      t.string :name
      t.string :iso_639_1

      t.timestamps
    end
  end
end
