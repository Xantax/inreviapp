Rails.application.routes.draw do

  resources :alerts

  get 'activities/index'

  root 'static_pages#home'  
  
  match 'terms' => "static_pages#terms", via: [:get]
  match 'buycredit' => "static_pages#buycredit", via: [:get]
  match 'how' => "static_pages#howworks", via: [:get]
  match 'first_message' => "static_pages#first_message", via: [:get]
  match 'offerz/search' => "offers#search", via: [:get]
  match 'servicez/search' => "services#search", via: [:get]
  match 'jobz/search' => "jobs#search", via: [:get]
  match 'rentz/search' => "rents#search", via: [:get]
  match 'workz/search' => "works#search", via: [:get]
  
  resources :activities
  resources :relationships, only: [:create, :destroy]  
  resources :reviews
  resources :messages

  resources :conversations do
    member do
      get :requestz, :confirm_order
    end
    resources :messages
    resources :reviews
  end

  devise_for :users  
  resources :users do
    member do
      get :following, :followers, :banning, :real_code
    end
    resources :conversations
  end  

  resources :phone_verifications
  
  resources :offers do
    member do
      get 'promotion'
      get 'imaging'
      get 'remove'
    end
    resources :promoted_offers
    resources :conversations
  end
  
  resources :services do
    member do
      get 'promotion'
    end
    resources :promoted_services
    resources :conversations
  end
  
  resources :rents do
    member do
      get 'promotion'
    end
    resources :promoted_rents
    resources :conversations
  end
  
  resources :works do
    member do
      get 'promotion'
    end
    resources :conversations
    resources :promoted_works
  end
    
    resources :promoted_offers
    resources :promoted_rents
    resources :promoted_services
    resources :promoted_works
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
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
