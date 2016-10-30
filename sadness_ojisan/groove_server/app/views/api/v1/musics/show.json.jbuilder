json.set! :data do
  json.merge! @music.attributes
  json.set! :records do
    json.array!(@music.records) do |record|
      json.merge! record.attributes
    end
  end
  json.used_count @music.records.count
end
