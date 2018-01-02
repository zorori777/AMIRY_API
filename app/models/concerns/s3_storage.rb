module S3Storage
  extend ActiveSupport::Concern

  included do
    def s3_directory
      case Rails.env
        when 'production'; 'amiry-production'
        when 'staging'; 'amiry-staging'
        when 'development'; 'amiry-development'
        when 'test'; 'amiry-development'
        else 'amiry-development'
      end
    end

    def image_url
      raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
    end
  end
end
