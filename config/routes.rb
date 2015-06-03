Rails.application.routes.draw do

  devise_for :users
  resources :users, except: :show do
    member do
      get 'donation_pending_amounts'
    end
  end
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  resource :donations, only: [:new, :create]
  root 'home#index'
  # root 'welcome#index'
  resources :reports, only: [] do 
    collection do 
      get :collections
      get :submissions
      get :pendings
      get :coordinator_submissions
    end
  end

  resources :donation_submissions, only: [:new, :create]
  get "user/change-password/:user_id" => "users#change_password", as: :change_password
  post "user/update-password/:user_id" => "users#update_password", as: :update_password

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
