json.extract! dancer, :id, :name, :email, :image, :crypted_password, :salt, :remember_me_token, :remember_me_token_expires_at, :created_at, :updated_at
json.url dancer_url(dancer, format: :json)