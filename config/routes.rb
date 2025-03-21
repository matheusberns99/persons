Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  match 'persons/:id/recover' => 'persons#recover', via: :patch
  resources :persons, only: %i[index show create update destroy] do

  end
end
