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

  it 'posts works' do
    validator = Jekyll::DataValidation::Validator.new(config)
    validator.process_site
    errors = validator.validate_posts(schema)
    assert_equal 1, errors.length
  end

  it 'pages works' do
    validator = Jekyll::DataValidation::Validator.new(config)
    validator.process_site
    errors = validator.validate_pages(schema)
    assert_equal 1, errors.length
  end

  def schema
    {
      # 'required' => ['permalink'],
      'properties' => {
        'unc' => {
          # 'type' => 'string',
          'format' => 'date-time'
        }
      }
    }
  end
end
