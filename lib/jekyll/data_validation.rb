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

    def schema
      {
        # 'required' => ['permalink'],
        'properties' => {
          'unc' => {
            # 'type' => 'string',
            'format' => 'date-time'
          }
        }
      }
    end

    def validate_pages
      @site.pages.each do |page|
        begin
          JSON::Validator.validate!(schema, page.data)
        rescue JSON::Schema::ValidationError => e
          puts "Jekyll page: #{page.path} failed validation."
          puts "Error: #{e.message}"
        end
      end
    end
  end
end
