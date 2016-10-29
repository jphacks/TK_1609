json.extract! record, :id, :title, :introduction, :effect, :movie, :dancer_id, :music_id, :created_at, :updated_at
json.url record_url(record, format: :json)