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
          'short-date',
          method(:short_date)
        )

        JSON::Validator.register_format_validator(
          'short-time',
          method(:short_time)
        )

        JSON::Validator.register_format_validator(
          'short-date-time',
          method(:short_date_time)
        )
      end

      def validate
        errors = []
        errors.concat(validate_data(@site.posts))
        errors.concat(validate_data(@site.pages))
        errors
      end

      private

      def short_date(value)
        verify(value, '"YYYY-MM-DD"', %r{^\d{4}-\d{2}-\d{2}$})
      end

      def short_time(value)
        verify(value, '"HH:MM"', %r{^\d{2}:\d{2}$})
      end

      def short_date_time(value)
        verify(value, '"YYYY-MM-DD HH:MM"', %r{^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$})
      end

      def verify(value, required_format, regex)
        verify_is_string(value, required_format)
        verify_can_be_parsed(value, required_format)
        verify_format(value, required_format, regex)
      end

      def verify_is_string(value, required_format)
        message = "is missing quotes. Use format #{required_format}"
        create_error(message) unless value.is_a? String
      end

      def verify_can_be_parsed(value, required_format)
        parsed_value = Time.parse(value)
      rescue ArgumentError
        message = "cannot be parsed. Use format #{required_format}"
        create_error(message)
      end

      def verify_format(value, required_format, regex)
        message = "has the wrong format. Use format #{required_format}"
        create_error(message) if value.match(regex).nil?
      end

      def create_error(message)
        raise JSON::Schema::CustomFormatError.new(message)
      end

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
