require 'fileutils'
require 'json-schema'

module Jekyll
  class DataValidation

    def initialize(jekyll_config)
      @site = Jekyll::Site.new(jekyll_config)
    end

    def process_site
      @site.process
    end

    def validate_pages
      schema = {
        # 'required' => ['permalink'],
        'properties' => {
          'unc' => {
            # 'type' => 'string',
            'format' => 'date-time'
          }
        }
      }

      @site.pages.each do |page|
        data = page.data
        begin
          JSON::Validator.validate!(schema, data)
        rescue JSON::Schema::ValidationError => e
          puts "File: #{page.path} failed validation."
          puts "Error: #{e.message}"
        end
      end
    end
  end
end
