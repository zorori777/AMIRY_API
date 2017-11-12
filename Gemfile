source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# FUNDAMENTAL
gem 'rails', '~> 5.1.3'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'dotenv-rails'
gem 'rake', '< 11.0'

# HAML
gem 'erb2haml'
gem 'haml-rails'

# SCSS 
gem 'sass-rails', '~> 5.0'

# JAVASCRIPT
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# IMAGE UPLOAD
gem 'carrierwave'
gem 'fog'

# COUNT UPDOWN
gem 'counter_culture'

# DECORATER
gem 'draper'

# SERIALIZER
gem 'active_model_serializers', '~> 0.9.7'

# AUTHENTICATION
gem 'devise'
gem 'omniauth-facebook'

# AUTHORIZATION
gem 'cancancan'

# ACTIVEADMIN
gem 'activeadmin'

# API PAGINATION
gem 'kaminari'
gem 'api-pagination'

# Grape API
gem 'grape', '~> 1'
gem 'grape-entity'
gem 'hashie-forbidden_attributes'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'grape-middleware-logger'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  # DEBUG
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'

  # FAKE DATA
  gem 'faker'

  # TESTING FRAMEWORK
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # ANNOTATE
  gem 'annotate'

  # N + 1 MONITOR
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
