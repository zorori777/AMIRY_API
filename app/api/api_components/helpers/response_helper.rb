require 'date'

module APIComponents
  module Helpers
    module ResponseHelper
      ## 200 OK
      def present_ok(data, data_entity = nil, **opts)
        status 200
        present_success(data, data_entity, opts)
      end

      ## 201 Created
      def present_created(data, data_entity = nil, **opts)
        status 201
        present_success(data, data_entity, opts)
      end

      ## 204 No Content
      def present_no_content(data, data_entity = nil, **opts)
        status 204
        present_success(data, data_entity, opts)
      end

      def present_success(data, data_entity, **opts)
        options = data_entity ? { with: data_entity } : {}
        options.merge!(opts)
        present data, options
      end

      def error_400!(*args)
        _parameter_error(400, *args)
      end

      def error_403!(message = 'Forbidden')
        _error(message, 403)
      end

      def error_404!(message = 'Not Found')
        _error(message, 404)
      end

      def error_500!(*args)
        _error('Internal Server Error', 500, *args)
      end

      def _error(message, code, *args)
        message ||= args[0].message if args[0].is_a?(Exception)

        error!({
          error: {
            code: code,
            message: message,
          },
          with: APIComponents::Entities::Error
        }, code)
      end

      def _parameter_error(code, *args)
        messages = []
        if args[0].is_a? ActiveRecord::Base
          model = args[0]
          model.errors.each do |key|
            message = { key => [] }
            model.errors.full_messages_for(key).each { |full_message| message[key] << full_message }
            messages << message
          end
        else
          messages = args
        end

        error!({
          error: {
            code: code,
            messages: messages
          },
          with: APIComponents::Entities::ParameterError
        }, code)
      end
    end
  end
end
