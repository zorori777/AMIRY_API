Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  resources :circles, only: :index
  resources :articles, only: :index

end
