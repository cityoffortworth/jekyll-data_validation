require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module Formats
      class ShortDateTime

        include ErrorGenerator

        def initialize()
          JSON::Validator.register_format_validator(
            'short-date-time',
            method(:short_date_time)
          )
        end

        private

        def short_date_time(value)
          verify(value, '"YYYY-MM-DD HH:MM"', %r{^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$})
        end

      end
    end
  end
end
