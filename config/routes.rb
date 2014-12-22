Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  get '/job/:id/job_activity/:job_activity_id' => 'jobs#move_activity', as: 'move_activity'
  post "/job_activity/done" => "job_activities#done_job", as: "done_job"
  post "/job_activity/wip" => "job_activities#wip_job", as: "wip_job"
  post "/job_activity/reject" => "job_activities#reject_job", as: "reject_job"
  post "/jobs/filter" => "jobs#filter", as: "filter_activity"
  post "/jobs/filter_user_activity" => "jobs#filter_user_activity", as: "filter_user_activity"
  get "/jobs/upload_activities" => "jobs#upload_activities", as: "upload_activities"
  post "/jobs/upload_activities_save" => "jobs#upload_activities_save", as: "upload_activities_save"
  get "/jobs/activities" => "jobs#activities", as: "activities"
  get "/dashboard" => "home#dashboard"
  get "/jobs/report_home" => "jobs#report_home", as: "report_home"
  get "/jobs/holiday" => "jobs#holiday", as: "holiday"
  post "/jobs/add_holiday" => "jobs#add_holiday", as: "add_holiday"
  post "/jobs/report_filter" => "jobs#report_filter", as: "report_filter"
  get "/jobs/:id/delete_holiday" => "jobs#delete_holiday", as: "delete_holiday"
  root 'home#index'
  resources :jobs
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
