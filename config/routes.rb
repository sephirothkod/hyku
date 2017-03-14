Rails.application.routes.draw do
  mount BrowseEverything::Engine => '/browse'
  resource :site, only: [] do
    resources :roles, only: [:index, :update]
    resource :content_blocks, only: [:edit, :update]
    resource :labels, only: [:edit, :update]
    resource :appearances, only: [:edit, :update]
  end

  resources :accounts

  get '/account/sign_up' => 'account_sign_up#new'
  post '/account/sign_up' => 'account_sign_up#create'

  root 'hyrax/homepage#index'

  get 'splash', to: 'splash#index'
  get 'status', to: 'status#index'
  devise_for :users

  mount Blacklight::Engine => '/'
  mount Hyrax::Engine, at: '/'

  concern :searchable, Blacklight::Routes::Searchable.new
  concern :exportable, Blacklight::Routes::Exportable.new

  curation_concerns_collections
  curation_concerns_basic_routes do
    member do
      get :manifest
    end
  end
  curation_concerns_embargo_management

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  namespace :admin do
    resources :users, only: :index
  end

  mount Peek::Railtie => '/peek'
  mount Riiif::Engine => '/images', as: 'riiif'
  
    
  get '/csv/upload', to: 'csv#upload'
  post '/csv/upload', to: 'csv#create'
  get '/csv/generate', to: 'csv#generate'
  
  get 'cdm/collection', to: 'cdm#collection'
  get 'cdm/mappings/', to: 'cdm#mappings', as: 'cdm_mappings'
  post 'cdm/generate/', to: 'cdm#generate', as: 'cdm_generate'
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
