json.extract! record, :id :title, :introduction, :effect, :movie, :dancer_id, :created_at, :updated_at
json.set! :dancers do
  json.partial! "dancers/dancer", dancer: @dancer
end
