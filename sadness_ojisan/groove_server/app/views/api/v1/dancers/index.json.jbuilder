json.array! @dancers, partial: 'dancers/dancer', as: :dancer

# json.set! :data do
#   json.array!(@dancers) do |dancer|
#     json.merge! dancer.attributes
#   end
# end
