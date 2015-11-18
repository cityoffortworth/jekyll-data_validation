require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation::Formats do

  it 'does not blow up' do
    config = Jekyll.configuration({
      'config' => 'test/fixtures/_config.yml',
      'quiet' => true
    })
    validator = Jekyll::DataValidation::Validator.new(config)
    @errors = validator.validate

    date_fixer = Jekyll::DataValidation::DateFixer.new(config)
    date_fixer.fix_date_errors(@errors)
  end

end
