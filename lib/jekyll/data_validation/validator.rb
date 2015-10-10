require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class Validator

      def initialize(config)
        @site = Jekyll::Site.new(config)
        @site.process
        @schema = @site.config['data_validation']
        raise "Config file is missing data_validation section." if @schema.nil?
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
