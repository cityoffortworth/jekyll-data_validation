require 'jekyll'

module Jekyll
  module DataValidation
    class ValidateCommand < Jekyll::Command
      class << self

        def init_with_program(prog)
          prog.command(:validate) do |c|
            c.syntax 'validate [options]'
            c.description 'Validate the site data.'
            c.option 'config',  '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
            c.action { |args, options| validate(options) }
          end
        end

        def validate(options)
          options['quiet'] = true
          options = Jekyll.configuration(options)
          validator = Jekyll::DataValidation::Validator.new(options)
          errors = validator.validate
          abort_if_errors(errors)
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
          message.sub(/'#\//, "'").sub(/in schema .*/, '')
        end

      end
    end
  end
end
