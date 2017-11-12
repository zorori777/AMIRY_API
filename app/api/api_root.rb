require 'grape-swagger'

class APIRoot < Grape::API
  format :json
  # prefix :api

  add_swagger_documentation(
    hide_documentation_path: false,
    doc_version: 'Document 0.0',
    info: {
        title: 'Black Thunder',
        description: 'Black Thunder API'
    }
  )

  namespace :circle do
    namespace :overview do
      mount APIComponents::Controllers::Circle::Overview
    end
  end

end
