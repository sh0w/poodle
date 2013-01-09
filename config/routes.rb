Poodle::Application.routes.draw do
  devise_for :users,
             path_names: {sign_in: "login", sign_out: "logout"},
             :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :courses do
    resources :lessons do
      resources :pages do
        resources :resources
        resources :texts
        resources :links
        resources :images
        resources :uploads
      end
    end
    resources :comments
  end

  root :to => "static_pages#explore"


  match "/explore" => "static_pages#explore", :as => "explore"
  match "/about" => "static_pages#about", :as => "about"
  match "/team" => "static_pages#team", :as => "team"

  match 'courses/:course_id/start' => 'courses#take_course', :as => "start"
  match 'courses/:course_id/editDescription' => 'courses#editDescription'
  match 'courses/:course_id/editTitle' => 'courses#editTitle'
  match 'courses/:course_id/editImage' => 'courses#editImage'
  match 'courses/:course_id/update' => 'courses#update'

  match 'courses/:course_id/lessons/:lesson_id/editDescription' => 'lessons#editDescription'
  match 'courses/:course_id/lessons/:lesson_id/editTitle' => 'lessons#editTitle'
  match 'courses/:course_id/lessons/:lesson_id/editImage' => 'lessons#editImage'
  match 'courses/:course_id/lessons/:lesson_id/pages/:page_id/resources/:resource_id/updatePosition' => 'resources#updatePosition', :as => "updateResourcePosition"
  match 'courses/:course_id/lessons/:lesson_id/pages/:page_id/updatePosition' => 'pages#updatePosition'
  match 'courses/:course_id/lessons/:lesson_id/updatePosition' => 'lessons#updatePosition'

  match 'users/:username' => "users#show", :as => "user"
  match 'profile' => "users#current"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
