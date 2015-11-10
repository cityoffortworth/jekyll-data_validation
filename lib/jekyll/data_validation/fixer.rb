require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class Fixer

      def initialize(options)
        Jekyll::PluginManager.require_from_bundler
        @site = Jekyll::Site.new(options)
        @schema = @site.config['data_validation']
        raise "Config file is missing data_validation section." if @schema.nil?
      end

      def fix(errors)
        errors.each do |error|
          error[:problems].each do |problem|
            content = File.read(error[:file])
            data = {}
            if content =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
              content = $POSTMATCH
              data = SafeYAML.load($1)
            end
            value = find_value(problem)
            field = find_field(problem)
            data[field] = Time.parse(value.to_s).strftime('%Y-%m-%d')
            new_content = "#{data.to_yaml}---\n#{content}"
            File.write(error[:file], new_content)
          end
        end
      end

      private

      def find_value(problem)
        problem[:message].match(/with value (\S*)/).captures[0]
      end

      def find_field(problem)
        problem[:fragment].match(/#{}\/(\S*)/).captures[0]
      end

    end
  end
end