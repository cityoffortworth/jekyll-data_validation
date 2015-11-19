require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class Validator

      def initialize(options)
        Jekyll::PluginManager.require_from_bundler
        @site = Jekyll::Site.new(options)
        @schema = @site.config['data_validation']
        raise "Config file is missing data_validation section." if @schema.nil?
      end

      def validate
        @site.reset
        @site.read
        @site.generate
        errors = []
        errors.concat(validate_data(@site.posts))
        errors.concat(validate_data(@site.pages))
        @site.collections.each do |name, collection|
          errors.concat(validate_data(collection.docs))
        end
        errors
      end

      private

      def validate_data(documents)
        errors = []
        documents.each do |document|
          doc_errors = JSON::Validator.fully_validate(
            @schema,
            document.data,
            :errors_as_objects => true
          )
          unless doc_errors.empty?
            errors << {
              :file => document.path,
              :problems => doc_errors
            }
          end
        end
        errors
      end

    end
  end
end
