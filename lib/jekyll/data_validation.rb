require 'fileutils'

module Jekyll
  class DataValidation

    def initialize(jekyll_config)
      @site = Jekyll::Site.new(jekyll_config)
    end

    def process_site
      @site.process
    end

    def validate_pages
      @site.pages.each do |page|
        unless page.permalink.nil?
          page_dir = File.dirname(page.permalink)
          page_name = File.basename(page.permalink, ".*")
          sub_dir = 'api'
          sub_dir = File.join(sub_dir, page_dir) unless page_dir == '.'
          sub_dir = File.join(sub_dir, page_name) unless page_name == 'index'

          path = @site.source
          path = File.join(path, sub_dir)
          FileUtils.mkdir_p(path) unless Dir.exists?(path)

          data = page.data
          data['source-file'] = page.path

          name = 'data.json'
          File.write(File.join(path, name), JSON.pretty_generate(data))
          json_file = Jekyll::StaticFile.new(@site, @site.source, sub_dir, name)
          @site.static_files << json_file
        end
      end
    end

  end
end
