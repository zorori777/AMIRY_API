class ApplicationController < ActionController::Base
  include Rails::Pagination

  protect_from_forgery with: :exception
end
