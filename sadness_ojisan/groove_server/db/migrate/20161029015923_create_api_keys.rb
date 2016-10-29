class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.datetime :expires_at
      t.boolean :active
      t.references :dancer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
