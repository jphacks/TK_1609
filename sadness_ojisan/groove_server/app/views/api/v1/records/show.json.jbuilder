json.set! :data do
  json.merge! @record.attributes
  json.set! :music do
    if @record.music.present? then
      json.merge! @record.music.attributes
    else
       'null'
    end

  end
  json.set! :favorites do
    json.merge! @record.favorites.count
  end
  json.set! :comments do
    json.array!(@record.comments) do |comment|
      json.merge! comment.attributes
      json.set! :dancer do
        json.merge! comment.dancer.attributes
      end
    end
  end
end
