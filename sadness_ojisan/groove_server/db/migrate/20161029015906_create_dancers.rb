class CreateDancers < ActiveRecord::Migration
  def change
    create_table :dancers do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :crypted_password
      t.string :salt
      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at

      t.timestamps null: false
    end
  end
end
