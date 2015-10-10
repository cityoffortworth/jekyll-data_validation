require 'fileutils'
require 'json-schema'

module Jekyll
  class DataValidation

    def process_site(jekyll_config)
      @site = Jekyll::Site.new(jekyll_config)
      @site.process
    end

    def validate_posts(schema)
      validate_data(@site.posts, schema)
    end

    def validate_pages(schema)
      validate_data(@site.pages, schema)
    end

    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      namespace :validate do
        desc 'Validate Jekyll page data'
        task :pages, [:schema] do |t, args|
        end
      end
    end

    private

    def validate_data(documents, schema)
      errors = []
      documents.each do |document|
        doc_errors = JSON::Validator.fully_validate(schema, document.data)
        unless doc_errors.empty?
          errors << {
            :file => document.path,
            :errors => doc_errors
          }
        end
      end
      errors
    end
  end
end

Jekyll::DataValidation.new.install_tasks
