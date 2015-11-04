require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    module Formats
      class ShortTime

        include ErrorGenerator

        def initialize()
          JSON::Validator.register_format_validator(
            'short-time',
            method(:short_time)
          )
        end

        private

        def short_time(value)
          verify(value, '"HH:MM"', %r{^\d{2}:\d{2}$})
        end

      end
    end
  end
end
