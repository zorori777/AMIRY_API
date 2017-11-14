require 'grape-swagger'

class APIRoot < Grape::API
  version 'v1'
  format :json
  prefix :api

  namespace :circle do
    mount APIComponents::Controllers::CirclesController
  end

  namespace :article do
    mount APIComponents::Controllers::ArticlesController
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
