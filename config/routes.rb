Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get "/pages/:page" => "pages#show"

  resources :trips do
    resources :hometowns, only: [:new, :create, :show]
  end

  get "/send-email/:trip_id", to: "trips#send_email"
end
