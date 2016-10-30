class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :title
      t.text :introduction
      t.string :effect
      t.string :movie
      t.references :dancer, index: true, foreign_key: true
      t.references :music, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
