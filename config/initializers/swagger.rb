GrapeSwaggerRails.options.url = '/api/v1/swagger_doc'
GrapeSwaggerRails.options.before_action do |request|
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  authenticate_or_request_with_http_basic do |username, pass|
    username == ENV['BASIC_AUTH_USERNAME'] && pass == ENV['BASIC_AUTH_PASSWORD']
  end
end
GrapeSwaggerRails.options.app_name = 'AMIRY'
