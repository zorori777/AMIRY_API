module APIComponents
  module Errors
    class ErrorBase < StandardError
      attr_reader :detail

      def initialize(*args, **opts)
        @detail = opts.fetch(:detail, '')
        super *args
      end
    end
  end
end
