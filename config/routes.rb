require 'sidekiq/web'

Rails.application.routes.draw do
  # ************************************************************************
  #                        Routing for admin
  # ************************************************************************
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  # ************************************************************************
  #                        Routing for api
  # ************************************************************************
  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/api-spec'

  # ************************************************************************
  #                        Routing for sidekiq
  # ************************************************************************
  mount Sidekiq::Web => '/sidekiq'

  get '/welcome/hoge' => 'welcome#hoge'
  get '/welcome/fuga' => 'welcome#fuga'
  get '/welcome/login' => 'welcome#login'
end
