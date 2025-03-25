Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { sessions: "users/sessions" }, skip: :all

  devise_scope :user do
    post "users/sign_in", to: "users/sessions#create"
    delete "users/sign_out", to: "users/sessions#destroy"
  end

  concern :recoverable do
    patch "recover", on: :member
  end

  resources :persons, only: %i[index show create update destroy], concerns: :recoverable do
    resources :addresses, only: %i[index show create update destroy], controller: "persons/addresses", concerns: :recoverable
  end

  resources :users, only: %i[index show create update destroy], concerns: :recoverable
end
