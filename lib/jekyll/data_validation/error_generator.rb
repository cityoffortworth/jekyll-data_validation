require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module ErrorGenerator

      def verify(value, required_format, regex)
        # verify_is_string(value, required_format)
        verify_can_be_parsed(value.to_s, required_format)
        # verify_format(value, required_format, regex)
      end

      def verify_is_string(value, required_format)
        message = "with value #{value} is missing quotes. Use format #{required_format}."
        create_error(message) unless value.is_a? String
      end

      def verify_can_be_parsed(value, required_format)
        parsed_value = Time.parse(value)
      rescue ArgumentError
        message = "with value #{value} cannot be parsed. Use format #{required_format}."
        create_error(message)
      end

      def verify_format(value, required_format, regex)
        message = "with value #{value} has the wrong format. Use format #{required_format}."
        create_error(message) if value.match(regex).nil?
      end

      def create_error(message)
        raise JSON::Schema::CustomFormatError.new(message)
      end

    end
  end
end
