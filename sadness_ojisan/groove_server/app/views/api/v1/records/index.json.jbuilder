json.set! :data do
  json.array!(@records) do |record|
    json.merge! record.attributes
    json.set! :music do
      json.merge! record.music.attributes
    end
    json.set! :comments do
      json.array!(record.comments) do |comment|
        json.merge! comment.attributes
      end
    end
    json.set! :favorites do
      json.merge! record.favorites.count
    end
  end
end
