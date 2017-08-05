# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for(:users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' })

  resources :dolphins, only: %i[create index]

  root 'dolphins#index'
end
