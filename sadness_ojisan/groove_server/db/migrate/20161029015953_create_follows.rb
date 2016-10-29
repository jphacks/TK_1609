class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :dancer, index: true, foreign_key: true
      t.integer :follow_id

      t.timestamps null: false
    end
  end
end
