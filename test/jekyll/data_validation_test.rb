require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation do
  let(:jekyll_config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'quiet' => true
    })
  end

  it 'it works' do
    data_validation = Jekyll::DataValidation.new(jekyll_config)
    data_validation.process_site
    data_validation.validate_posts(schema)
    data_validation.validate_pages(schema)
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
