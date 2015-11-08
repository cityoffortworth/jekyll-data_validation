require 'jekyll/data_validation'

module Jekyll
  module DataValidation
    class Tasks

      include Rake::DSL if defined? Rake::DSL

      def install
        desc 'Validate Jekyll page data'
        task :validate, [:config] do |t, args|
          config = Jekyll.configuration({
            'config' => args.config,
            'quiet' => true
          })
          validator = Jekyll::DataValidation::Validator.new(config)
          errors = validator.validate
          abort_if_errors(errors)
        end
      end

      def abort_if_errors(errors)
        unless errors.empty?
          errors.sort! { |x,y| x[:file] <=> y[:file] }
          errors_count = 0
          errors.each do |error|
            errors_count += 1
            puts "#{errors_count}. #{error[:file]} failed validation."
            error[:messages].each do |message|
              trimmed_message = trim_message(message)
              puts "  #{trimmed_message}"
            end
            puts
          end
          message = "Validation failed. See the list above for files that need to be corrected."
          raise Jekyll::DataValidation::ValidationError.new(message)
        end
      end

      def trim_message(message)
        message.sub(/in schema .*/, '')
      end

    end
  end
end

Jekyll::DataValidation::Tasks.new.install
