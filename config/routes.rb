Rails.application.routes.draw do

  resources :reviews

  resources :orders do
    resources :reviews
  end
  resources :buy_requests
  resources :messages

  resources :conversations do
    resources :messages
    resources :buy_requests
    resources :orders
    resources :reviews
  end

  devise_for :users  
  resources :users do
    resources :conversations
    resources :promoted_offers
  end
  resources :user_identifications
  resources :phone_codes
  resources :phone_verifications
  resources :promoted_offers
  
  resources :offers do
    resources :promoted_offers
    resources :conversations
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'  
  
  match 'terms' => "static_pages#terms", via: [:get]
  match 'buycredit' => "static_pages#buycredit", via: [:get]
  match 'how' => "static_pages#howworks", via: [:get]
  match 'verify' => "static_pages#user_verification", via: [:get]
  match 'offerz/search' => "offers#search", via: [:get]
  
  get 'tags/:tag', to: 'offers#index', as: :tag
  
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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
