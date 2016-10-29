# ダンサーのshowで返すのは, dancer情報と, そのダンサーのダンス記録

json.set! :data do
  json.merge! @dancer.attributes
  json.set! :records do
    json.array!(@dancer.records) do |record|
      json.merge! record.attributes
    end
  end
  json.set! :rank_records do
    json.array!(@rank_records) do |rank_record|
      json.merge! rank_record.attributes
    end
  end
  json.set! :follower_records do
    json.array!(@follower_records) do |follower_record|
      json.merge! follower_record.attributes
    end
  end
  json.set! :favorite_records do
    json.array!(@favorite_records) do |favorite_record|
      json.merge! favorite_record.attributes
    end
  end
end
