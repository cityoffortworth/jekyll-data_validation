require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation::DateFixer do

  let(:fixtures) { File.join('test', 'fixtures') }
  let(:saved_fixtures) { File.join('test', 'saved-fixtures') }

  def setup
    FileUtils.rm_r(saved_fixtures) if Dir.exists?(saved_fixtures)
    FileUtils.cp_r(fixtures, saved_fixtures)
  end

  def teardown
    FileUtils.rm_r(fixtures)
    FileUtils.mv(saved_fixtures, fixtures)
  end

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
