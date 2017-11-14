Rails.application.routes.draw do
  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/api-spec'

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users
end
