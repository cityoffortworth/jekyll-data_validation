require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module Formats
      class ShortDate

        include ErrorGenerator

        def initialize()
          JSON::Validator.register_format_validator(
            'short-date',
            method(:short_date)
          )
        end

        private

        def short_date(value)
          verify(value, '"YYYY-MM-DD"', %r{^\d{4}-\d{2}-\d{2}$})
        end

      end
    end
  end
end
