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

# AUTHENTICATION
gem 'devise'
gem 'omniauth-facebook'
gem 'jwt'
gem 'faraday'

# AUTHORIZATION
gem 'cancancan'

# ACTIVEADMIN
gem 'activeadmin'

# API PAGINATION
gem 'kaminari'

# Grape API
gem 'grape', '1.0.0'
gem 'grape-entity', '0.6.1'
gem 'hashie-forbidden_attributes', '0.1.1'
gem 'grape-swagger', '0.27.2'
gem 'grape-swagger-entity', '0.2.0'
gem 'grape-swagger-rails', '0.3.0'
gem 'grape-middleware-logger', '1.9.0'

# CORS
gem 'rack-cors'

group :production do
  # APPLICATION SERVER  
  gem 'unicorn'
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  # TESTING FRAMEWORK
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'

  # FAKE DATA
  gem 'faker', git: 'git://github.com/stympy/faker.git', branch: 'master'

  # DEBUG
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
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

  # AUTOMATIC DEPLOY
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
