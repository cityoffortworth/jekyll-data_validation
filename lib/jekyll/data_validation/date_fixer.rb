require 'json-schema'
require 'jekyll'

module Jekyll
  module DataValidation
    class DateFixer

      def initialize(options)
        Jekyll::PluginManager.require_from_bundler
        @site = Jekyll::Site.new(options)
        @schema = @site.config['data_validation']
        raise "Config file is missing data_validation section." if @schema.nil?
      end

      def fix_date_errors(errors)
        errors.each do |error|
          error[:problems].each do |problem|
            if can_be_corrected_by_reformatting?(problem)
              path = file_path(error)
              data, content = read_file_with_error(path)
              value = find_value(problem)
              field = find_field(problem)

              reformatted = reformat(value, problem)
              data.gsub!(/^#{field}:.*$/, "#{field}: \"#{reformatted}\"")
              new_content = "#{data}---#{content}"
              File.write(path, new_content)
            end
          end
        end
      end

      private

      def can_be_corrected_by_reformatting?(problem)
        problem[:message] =~ /(is missing quotes|has the wrong format)/
      end

      def read_file_with_error(path)
        content = File.read(path)
        if content =~ /\A(---\s*\n.*?\n?)^(---)/m
          content = $POSTMATCH
          data = $1
        else
          raise "#{path} is not a YAML file. Expecting errors to be in YAML."
        end
        [data, content]
      end

      def file_path(error)
        if error[:file].start_with?(@site.source)
          error[:file]
        else
          File.join(@site.source, error[:file])
        end
      end

      def find_value(problem)
        problem[:message].match(/with value ([0-9T:\-\s]*)/).captures[0].strip
      end

      def find_field(problem)
        problem[:fragment].match(/#\/(\S*)/).captures[0]
      end

      def reformat(value, problem)
        reformat_string = get_reformat_string(problem)
        time = Time.parse(value.to_s)
        # if time.strftime("%H:%M") == "00:00"
        #   reformat_string = "%Y-%m-%d"
        # end
        reformatted = time.strftime(reformat_string)
      rescue
        reformatted = value
      end

      def get_reformat_string(problem)
        case problem[:message].match(/Use format "(.*)"\./).captures[0]
        when "YYYY-MM-DD HH:MM"
          "%Y-%m-%d %H:%M"
        when "YYYY-MM-DD"
          "%Y-%m-%d"
        when "HH:MM"
          "%H:%M"
        else
          raise "Did not find a formatting in error message."
        end
      end

    end
  end
end
