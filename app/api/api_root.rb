require 'grape-swagger'

class APIRoot < Grape::API
  version 'v1'
  format :json
  prefix :api

  helpers APIComponents::Helpers::ResponseHelper

  namespace do
    mount APIComponents::Controllers::ArticlesController
  end

  namespace :auth_tokens do
    mount APIComponents::Controllers::AuthTokensController
  end

  namespace :bands do
    mount APIComponents::Controllers::BandsController
  end

  namespace :circles do
    mount APIComponents::Controllers::CirclesController
  end

  namespace :introductions do
    mount APIComponents::Controllers::IntroductionsController
  end

  namespace :lives do
    mount APIComponents::Controllers::LivesController
  end

  namespace :lectures do
    mount APIComponents::Controllers::LecturesController
  end

  namespace :likes do
    mount APIComponents::Controllers::LikesController
  end

  namespace :me do
    mount APIComponents::Controllers::MeController
  end

  namespace :messages do
    mount APIComponents::Controllers::MessagesController
  end

  namespace :universities do
    mount APIComponents::Controllers::UniversitiesController
  end

  namespace :users do
    mount APIComponents::Controllers::UsersController
  end

  namespace :user_bands do
    mount APIComponents::Controllers::UserBandsController
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error_400! e
  end

  rescue_from APIComponents::Errors::UnauthorizedError do |e|
    error_403! e
  end

  rescue_from APIComponents::Errors::RecordNotFoundError do |e|
    error_404! e
  end

  add_swagger_documentation(
    hide_documentation_path: false,
    doc_version: 'Document 0.0',
    info: {
      title: 'AMIRY',
      description: 'AMIRY API'
    }
  )
end
