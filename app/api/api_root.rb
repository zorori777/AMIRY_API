require 'grape-swagger'

class APIRoot < Grape::API
  version 'v1'
  format :json
  prefix :api

  namespace :articles do
    mount APIComponents::Controllers::ArticlesController
  end

  namespace :bands do
    mount APIComponents::Controllers::BandsController
  end

  namespace :circles do
    mount APIComponents::Controllers::CirclesController
  end

  namespace :lives do
    mount APIComponents::Controllers::LivesController
  end

  namespace :lectures do
    mount APIComponents::Controllers::LecturesController
  end

  namespace :universities do
    mount APIComponents::Controllers::UniversitiesController
  end

  namespace :me do
    mount APIComponents::Controllers::MeController
  end

  route :any, '*path' do
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
