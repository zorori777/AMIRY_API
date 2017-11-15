Rails.application.routes.draw do
  mount APIRoot => '/'
  mount GrapeSwaggerRails::Engine => '/api-spec'

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get '/welcome/hoge' => 'welcome#hoge'
  get '/welcome/fuga' => 'welcome#fuga'
  get '/welcome/login' => 'welcome#login'
end
