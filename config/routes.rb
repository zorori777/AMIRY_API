Rails.application.routes.draw do
  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/api-spec'

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get '/welcome/hoge' => 'welcome#hoge'
  get '/welcome/fuga' => 'welcome#fuga'
  get '/welcome/login' => 'welcome#login'
end
