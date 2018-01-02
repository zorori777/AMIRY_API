module FileModelInterface
  extend ActiveSupport::Concern

  included do
    # Constant
    AMAZON_S3_DOMAIN = 'https://s3-ap-northeast-1.amazonaws.com'

    # Getter Methods
    def s3_directory
      case Rails.env
        when 'production'; 'amiry-production'
        when 'staging'; 'amiry-staging'
        when 'development'; 'amiry-development'
        when 'test'; 'amiry-development'
        else 'amiry-development'
      end
    end

    def file_url
      "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.class.to_s}/#{self.name.file.filename}"
    end
  end
end
