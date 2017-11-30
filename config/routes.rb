Rails.application.routes.draw do
  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/api-spec'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  get '/welcome/hoge' => 'welcome#hoge'
  get '/welcome/fuga' => 'welcome#fuga'
  get '/welcome/login' => 'welcome#login'
end
