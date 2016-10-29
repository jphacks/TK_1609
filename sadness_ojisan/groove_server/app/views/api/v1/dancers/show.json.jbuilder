# ダンサーのshowで返すのは, dancer情報と, そのダンサーのダンス記録

json.set! :data do
  json.merge! @dancer.attributes
  json.set! :records do
    json.array!(@dancer.records) do |record|
      json.merge! record.attributes
    end
  end
end
