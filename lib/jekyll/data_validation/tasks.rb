require 'jekyll/data_validation/validator'

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
          errors.each do |error|
            puts "#{error[:file]} failed validation."
            error[:messages].each do |message|
              puts "  #{message}"
            end
          end
          puts
          abort "#{errors.length} files failed validation. See the list above for the files that have data that needs to be corrected."
        end
      end

    end
  end
end

Jekyll::DataValidation::Tasks.new.install
