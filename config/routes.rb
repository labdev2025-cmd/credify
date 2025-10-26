Rails.application.routes.draw do
  scope :credify do
    resources :categorias
    resources :cartoes
    resources :pessoas
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
