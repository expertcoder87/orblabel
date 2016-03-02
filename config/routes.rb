Rails.application.routes.draw do
  devise_for :stores, :path => '',:path_names => {:sign_up => 'solicitar-conta', :sign_in => 'acesso-da-loja'} ,
  :controllers=>{:registrations => "registrations",:sessions=>"sessions",:passwords=>"passwords"}
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'static_pages#index'

  # static pages like home, about, contact, etc...

  # Main Page Routes Methods 

  get 'sobre', :to => 'static_pages#about'
  get 'contato', :to => 'static_pages#contact'
  get 'recuperar-senha', :to => 'static_pages#recover_password'
  get 'termos-de-uso', :to => 'static_pages#terms_of_use',as: "termos-de-uso"
  get 'access_da_loja',:to => 'static_pages#access_da_loja',as: "access_da_loja"

  get 'lojas-autorizadas', :to => 'stores#index'
  get 'store',:to => 'stores#show'
  get 'check_cnpj_cpf',:to => 'stores#check_cnpj_cpf'
  get 'display_message/:id',:to => 'stores#display_message',as: 'display_message'
  # Store Page Routes Methods
  resources :bikes
  get 'buscar_bicicleta',:to => 'bikes#buscar_bicicleta'
  get '/access_code/:id',:to=>'bikes#access_code',as: "access_code"
  get 'certified_bikes/:id',:to=>'bikes#certified_bikes',as: "certified_bikes"
  get 'uncertified_bikes/:id',:to=>'bikes#uncertified_bikes',as: "uncertified_bikes"
  get 'register_new_piece',:to=>'bikes#register_new_piece'
  get 'peca_antiga_details', :to=>'bikes#peca_antiga_details'
  post 'requisitar_certificados', :to=>'bikes#requisitar_certificados',as: 'requisitar_certificados'
  get 'recover_password/:id',:to=>'stores#recover_password',as:'recover_password' 
  patch 'reset_password',:to=>'stores#reset_password',as: 'reset_password'
  get 'sign_up_mail/:id',:to=>'stores#sign_up_mail',as: 'sign_up_mail'
  post 'contact',:to=>'stores#contact',as: 'contact'

  # Admin Page Routes Methods
  get 'admin_store',:to=>'stores#admin_store',as: 'admin_store'
  get 'admin_bike',:to=>'bikes#admin_bike',as: 'admin_bike'
  get 'admin_maintenance_events/:id',:to=>'bikes#admin_maintenance_events',as: 'admin_maintenance_events'
  get 'admin_certificate',:to=>'bikes#admin_certificate',as: 'admin_certificate'
  get 'admin_certificate_destroy/:id',:to=>'bikes#admin_certificate_destroy',as: 'admin_certificate_destroy'
  get 'store_alert',:to=>'bikes#store_alert',as: 'store_alert'
  get 'admin_access_code/:id',:to=>'bikes#generate_access_code',as: 'admin_access_code'
  post 'admin_create_event',:to=>'maintenances_events#admin_create_event',as: 'admin_create_event'
  put 'admin_update_event',:to=>'maintenances_events#update',as: 'admin_update_event'
  put 'change_certificate',:to=>'bikes#change_certificate',as: 'change_certificate'
  get 'admin_genarate_certificate',:to=>'bikes#generate_certificate',as: 'admin_genarate_certificate'
  get 'admin_new_registration',:to=>'stores#registration_new',as: 'admin_new_registration'
  post 'admin_sign_up',:to=>'stores#admin_sign_up',as: 'admin_sign_up'
  get 'admin_edit_registration/:id',:to=>'stores#registration_edit',as: 'admin_edit_registration'
  patch 'admin_store_update',:to=>'stores#store_update',as: 'admin_store_update'
  post 'admin_store_destroy/:id',:to=>'stores#store_destroy',as: 'admin_store_destroy'
  post 'bike_destroy/:id',:to=>'bikes#bike_destroy',as: 'bike_destroy'
  get 'cpf_check',:to=>'bikes#cpf_check',as:'cpf_check'
  # Maintenance Event Routes
  post 'register_maintenance_events',:to=>'maintenances_events#create'
  
  
  # BikePart routes
  post 'register_new_bike_piece', :to=>'bike_parts#register_new_bike_piece'
  post 'bike_part_create',:to=>'bike_parts#create',as: 'bike_part_create'
  get 'bike_part_destroy/:id',:to=>'bike_parts#destroy',as: 'bike_part_destroy'
  # get 'bike',:to => 'bikes#show'

  # Uncertified Bikes
  resources :uncertified_bikes
  post 'create/:id',:to=>'uncertified_bikes#create',as: 'uncertified_bikes_vender'
  put 'update',:to=>'uncertified_bikes#update',as: 'update_uncertified_bike'
  post 'vender_bicicleta',:to => 'uncertified_bikes#vender_bicicleta',as: "vender_bicicleta"
  post 'transfer_bicicleta',:to => 'uncertified_bikes#transfer_bicicleta',as: 'transfer_bicicleta'
  get 'vender_bicicleta_model',:to => 'bikes#vender_bicicleta_model',as: 'vender_bicicleta_model'
  put 'vender_bicicleta_model_update',:to => 'uncertified_bikes#vender_bicicleta_model_update',as: 'vender_bicicleta_model_update'
  #Bike Page For GuestUser
  get 'certified',:to=>'bikes#certified',as: 'certified_number'
  get 'acesso_do_proprietario/:id',:to=>'bikes#acesso_do_proprietario',as: 'acesso_do_proprietario'  
  # Bike Page For Bike Owner
  get 'proprietario_bicicleta_cerified/:id', :to=>'bikes#certified_bike_owner',as: 'proprietario_bicicleta_cerified'
  get 'bike_bike_part_details/:id',:to=>'bikes#bike_bike_part_details',as: 'bike_bike_part_details'
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
