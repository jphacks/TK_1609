json.set! :data do
  json.array!(@questions) do |question|
    json.merge! question.attributes
    json.set! :dancer do
      json.merge! question.dancer.attributes
    end
  end
end
