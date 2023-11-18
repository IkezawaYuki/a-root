Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'insta/webhooks' =>'insta#confirm'
      post 'insta/webhooks' => 'insta#webhook_notice'
    end
  end
  get 'admin/index'
  get 'admin/login'
  get 'admin/logout'
  get 'admin/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  root "home#index"
  get 'home/login'

end
