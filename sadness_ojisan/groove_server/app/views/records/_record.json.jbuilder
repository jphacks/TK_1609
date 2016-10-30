json.extract! record, :id, :title, :introduction, :effect, :movie, :dancer_id, :created_at, :updated_at
json.set! :dancer do
  json.extract! record.dancer, :id, :name
end
