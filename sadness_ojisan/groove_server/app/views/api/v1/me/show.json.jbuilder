# ダンサーのshowで返すのは, dancer情報と, そのダンサーのダンス記録

json.set! :data do
  json.partial! "dancers/dancer", dancer: @dancer
  json.set! :records do
    json.array! @dancer.records, partial: 'records/record', as: :record
  end
  json.set! :rank_records do
    json.array! @rank_records, partial: 'records/record', as: :record
  end
  json.set! :follower_records do
    json.array! @follower_records, partial: 'records/record', as: :record
  end
  json.set! :favorite_records do
    json.array! @favorite_records, partial: 'records/record', as: :record
  end
end
