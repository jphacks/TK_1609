json.extract! music, :id, :name, :bpm, :file, :created_at, :updated_at
json.url music_url(music, format: :json)