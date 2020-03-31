# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for(:users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' })

  get 'blacklisted', to: 'application#blacklisted'

  resources :dolphins, only: :create

  root 'dolphins#index'
end
