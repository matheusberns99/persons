Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  concern :recoverable do
    patch "recover", on: :member
  end

  resources :persons, only: %i[index show create update destroy], concerns: :recoverable do
    resources :addresses, only: %i[index show create update destroy], controller: "persons/addresses", concerns: :recoverable
  end
end
