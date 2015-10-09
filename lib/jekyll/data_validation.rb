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

    def validate_posts(schema)
      @site.posts.each do |post|
        begin
          JSON::Validator.validate!(schema, post.data)
        rescue JSON::Schema::ValidationError => e
          puts "Jekyll post: #{post.path} failed validation."
          puts "Error: #{e.message}"
        end
      end
    end

    def validate_pages(schema)
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
