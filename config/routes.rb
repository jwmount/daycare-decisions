DaycareDecisions::Application.routes.draw do


# API routes

# <host>/addresses => all of them
# <host>/addresses/200  => 200th of them

  namespace :api do  
    get 'names',                          to: :names
    get 'names/:name',                    to: :names
    get 'rolodex/:id',                    to: :rolodex
    get 'states',                         to: :states
    get 'states/:state',                  to: :states
    # GET /api/locations/<partial string>
    # for example:  <host>/api/locations/Bris
    get 'locations/:locality',           to: :locations
    get 'providers',                     to: :providers
    get 'provider/:id',                  to: :provider
    get 'state/:state',                  to: :state
    get '/',                             to: :help
  
  end #:api namespace

#
# Example of named route that can be invoked with purchase_url(id: product.id)
# get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
#
  resources :home
    # reference as about_path in HomeController views
    get 'about',                to: 'home#about',             as: :about
    get 'advertise',            to: 'home#advertise',         as: :advertise
    get 'contact_us',           to: 'home#contact_us',        as: :contact_us
    get 'faq',                  to: 'home#faq',               as: :faq
    get 'fact_sheets',          to: 'home#fact_sheets',       as: :fact_sheets
    get 'research',             to: 'home#research',          as: :research
    get 'newsletter',           to: 'home#newsletter',        as: :newsletter
    get 'privacy_policy',       to: 'home#privacy_policy',    as: :privacy_policy
    get 'provider_services',    to: 'home#provider_services', as: :provider_services
    get 'terms_conditions',     to: 'home#terms_conditions',  as: :terms_conditions


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # this namespace is probably irrelevent
  namespace :admin do

    resources :roles do
      resources :admin_users
    end

    resources :guardian do
      resources :waitlist_applications
    end

  end #:admin namespace


  root to: "home#index"

  #root to: "frontend#feui"
  #get '*path', to: 'frontend#feui'

  # catch-all route for api_controller
  # http://www.tsheffler.com/blog/?p=428 -- note by Forrest Zeisler
  # get "*path" => "api#xss_options_request", :constraints => {:method => "OPTIONS"}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
