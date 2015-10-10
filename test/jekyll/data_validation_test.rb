require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation do

  let(:config) do
    Jekyll.configuration({
      'config'=> 'test/fixtures/_config.yml',
      'quiet' => true
    })
  end

  it 'validation works' do
    validator = Jekyll::DataValidation::Validator.new(config)
    errors = validator.validate
    assert_equal 2, errors.length
  end

end
