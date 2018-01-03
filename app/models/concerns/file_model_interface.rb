module FileModelInterface
  extend ActiveSupport::Concern

  included do
    # Constant
    AMAZON_S3_DOMAIN = 'https://s3-ap-northeast-1.amazonaws.com'

    # Getter Methods
    def s3_directory
      case Rails.env
      when 'production'  then 'amiry-production'
      when 'staging'     then 'amiry-staging'
      when 'development' then 'amiry-development'
      when 'test';       then 'amiry-development'
      else 'amiry-development'
      end
    end

    def file_url
      "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.class}/#{self.name.file.filename}"
    end
  end
end
