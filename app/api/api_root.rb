require 'grape-swagger'

class APIRoot < Grape::API
  version 'v1'
  format :json
  prefix :api

  namespace :circle do
    namespace :overview do
      mount APIComponents::Controllers::Circle::Overview
    end
  end

  add_swagger_documentation

end
