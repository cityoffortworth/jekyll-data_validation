require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class Validator

      def initialize(config)
        Jekyll::PluginManager.require_from_bundler
        @site = Jekyll::Site.new(config)
        @site.reset
        @site.read
        @site.generate
        @schema = @site.config['data_validation']
        raise "Config file is missing data_validation section." if @schema.nil?

        JSON::Validator.register_format_validator(
          'short-date-time',
          method(:short_date_time)
        )
      end

      def short_date_time(value)
        message = 'must have format "YYYY-MM-DD HH:MM"'
        raise JSON::Schema::CustomFormatError.new(message) unless value.is_a? String
        short_date_time = Time.parse(value)
      rescue ArgumentError
        message = 'is not a valid date. Use format "YYYY-MM-DD HH:MM"'
        raise JSON::Schema::CustomFormatError.new(message)
      end

      def validate
        errors = []
        errors.concat(validate_data(@site.posts))
        errors.concat(validate_data(@site.pages))
        errors
      end

      private

      def validate_data(documents)
        errors = []
        documents.each do |document|
          messages = JSON::Validator.fully_validate(@schema, document.data)
          unless messages.empty?
            errors << {
              :file => document.path,
              :messages => messages
            }
          end
        end
        errors
      end

    end
  end
end
