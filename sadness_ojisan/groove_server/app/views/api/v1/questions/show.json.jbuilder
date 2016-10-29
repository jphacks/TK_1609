json.set! :data do
  json.merge! @question.attributes
  json.set! :dancer do
    json.merge! @question.dancer.attributes
  end
  json.set! :answers do
    json.array!(@question.answers) do |answer|
      json.merge! answer.attributes
    end
  end
end
