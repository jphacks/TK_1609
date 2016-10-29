Rails.application.routes.draw do
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
