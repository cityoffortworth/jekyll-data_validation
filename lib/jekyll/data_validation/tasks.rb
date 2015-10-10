require 'jekyll/data_validation/validator'

module Jekyll
  module DataValidation
    class Tasks

      include Rake::DSL if defined? Rake::DSL
      def install
        namespace :validate do
          desc 'Validate Jekyll page data'
          task :pages, [:config] do |t, args|
            config = Jekyll.configuration({
              'config' => args.config,
              'quiet' => true
            })
            validator = Jekyll::DataValidation::Validator.new(config)
            site = validator.process_site
            schema = site.config['data_validation']
            errors = validator.validate_posts(schema)

            unless errors.empty?
              errors.each do |error|
                puts "Page: #{error[:file]} failed validation."
                error[:messages].each do |message|
                  puts "  #{message}"
                end
              end
              abort 'Pages failed validation.'
            end
          end
        end
      end

    end
  end
end

Jekyll::DataValidation::Tasks.new.install
