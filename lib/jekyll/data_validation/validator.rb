require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class Validator

      def initialize(config)
        @site = Jekyll::Site.new(config)
      end

      def process_site
        @site.process
        @site
      end

      def validate_posts(schema)
        validate_data(@site.posts, schema)
      end

      def validate_pages(schema)
        validate_data(@site.pages, schema)
      end

      private

      def validate_data(documents, schema)
        errors = []
        documents.each do |document|
          messages = JSON::Validator.fully_validate(schema, document.data)
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
