require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module Formats
      class UserTime

        include ErrorGenerator

        def initialize()
          JSON::Validator.register_format_validator(
            'user-time',
            method(:user_time)
          )
        end

        private

        def user_time(value)
          verify(value, '"HH:MM"', %r{^\d{2}:\d{2}$})
        end

      end
    end
  end
end
