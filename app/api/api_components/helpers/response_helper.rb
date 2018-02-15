require 'date'

module APIComponents
  module Helpers
    module ResponseHelper

      def _get_server_meta_data
        {
          server_clock: Time.zone.now
        }
      end

      ## 200 OK
      def present_ok(data, data_entity=nil, **opts)
        status 200
        present_success(data, data_entity, opts)
      end

      ## 201 Created
      def present_created(data, data_entity=nil, **opts)
        status 201
        present_success(data, data_entity, opts)
      end

      ## 204 No Content
      def present_no_content(data, data_entity=nil, **opts)
        status 204
        present_success(data, data_entity, opts)
      end

      def present_success(data, data_entity, **opts)
        options = data_entity ? { with: data_entity } : {}
        options.merge!(opts)
        present data, options
      end

      def error_404!(message = 'Not Found')
        _error(message, 404)
      end

      def _error(message, code, *args)
        if args[0].is_a? Exception
          message ||= args[0].message
        end

        error!({
          error: {
            code: 404,
            message: message,
          },
          with: APIComponents::Entities::Error
        }, code)
      end
    end
  end
end
