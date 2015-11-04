require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module Formats
      class UserDate

        include ErrorGenerator

        def initialize()
          JSON::Validator.register_format_validator(
            'user-date',
            method(:user_date)
          )
        end

        private

        def user_date(value)
          verify(value, '"YYYY-MM-DD"', %r{^\d{4}-\d{2}-\d{2}$})
        end

      end
    end
  end
end
