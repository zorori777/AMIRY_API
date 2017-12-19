module APIComponents
  module Errors
    class ErrorBase < StandardError
      include Grape::DSL::InsideRoute
    end
  end
end
