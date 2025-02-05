Gelatine::Application.routes.draw do
  resources :check_ins
  
  match 'tagged' => 'profiles#tagged', :as => 'tagged'
  
  resources :needs_help_with
  
  resources :profiles do
    get :autocomplete_skills_name, :on => :collection   
    get :autocomplete_needs_name, :on => :collection   
    get :autocomplete_interests_name, :on => :collection   
  end

  devise_for :users, :path => "auth", :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout',
    :password => 'secret',
    :confirmation => 'verification',
    :unlock => 'unblock',
    :registration => 'register',
  :sign_up => 'cmon_let_me_in' }

  resources :reservations
  resources :rooms
  resources :calendars

  namespace :api do
    namespace :v0 do
        resources :legacy_support
        match 'view_list_distinct_user_checkins_all' => "legacy_support#view_list_distinct_user_checkins_all"
        match 'view_list_distinctusercheckins_aggregated' => "legacy_support#view_list_distinctusercheckins_aggregated"
        match 'checkin_submit_manual' => "legacy_support#checkin_submit_manual"
    end
  end

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
  root :to => 'profiles#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
