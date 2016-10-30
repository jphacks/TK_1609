json.set! :data do
  json.merge! @dancer.attributes
  json.set! :records do
    json.array!(@dancer.records) do |record|
      json.merge! record.attributes
    end
  end
end

json.access_token @access_token
