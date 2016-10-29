Rails.application.routes.draw do
  get 'dancer_sessions/new'

  get 'dancer_sessions/create'

  get 'dancer_sessions/destroy'

  resources :answers
  resources :questions
  resources :follows
  resources :favorites
  resources :musics
  resources :comments
  resources :records
  resources :dancers
  namespace :api, { format: 'json' }  do
    namespace :v1 do
      resources :answers
      resources :questions
      resources :follows
      resources :favorites
      resources :musics
      resources :comments
      resources :records
      resources :dancers
    end
  end
end
