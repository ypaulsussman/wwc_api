# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    root to: 'application#lander'
    post 'login', to: 'tokens#create'

    resources :studies, only: [:index, :show]
    resources :study_searches, only: [:create] do
      post 'autocomplete', on: :collection
    end
  end
end
