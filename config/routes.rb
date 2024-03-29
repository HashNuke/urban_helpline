UrbanHelpline::Application.routes.draw do

  root 'main#index'
  devise_for :users

  match "admin" => "admin#index", via: :get

  match "data/calls"     => "data#calls", via: :get
  match "data/operators" => "data#operators", via: :get

  namespace :admin do
    match "phone_calls/handle" => "phone_calls#handle", via: [:get, :post]

    resources :documents do
      get 'review', on: :collection
      get 'search', on: :collection
    end

    resources :users
    resources :phone_calls
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
