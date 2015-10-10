require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation do
  let(:jekyll_config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'config'=> 'test/fixtures/_config.yml',
      'quiet' => true
    })
  end

  it 'posts works' do
    data_validation = Jekyll::DataValidation.new
    data_validation.process_site(jekyll_config)
    errors = data_validation.validate_posts(schema)
    assert_equal 1, errors.length
  end

  it 'pages works' do
    data_validation = Jekyll::DataValidation.new
    data_validation.process_site(jekyll_config)
    errors = data_validation.validate_pages(schema)
    assert_equal 1, errors.length
  end

  it 'provides custom config' do
    site = Jekyll::Site.new(jekyll_config)
    assert_equal 'hello', site.config['custom_stuff']
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
