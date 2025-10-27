Rails.application.routes.draw do
  get "home/index"
  scope :credify do
    root "home#index"
    resources :categorias
    resources :cartoes
    resources :pessoas
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
