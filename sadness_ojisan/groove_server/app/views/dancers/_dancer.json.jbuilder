json.extract! dancer, :id, :name, :email, :image, :crypted_password, :salt, :remember_me_token, :remember_me_token_expires_at, :created_at, :updated_at
json.set! :records do
  json.array! dancer.records, partial: 'records/record', as: :record
end
