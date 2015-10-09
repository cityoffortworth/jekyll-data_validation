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
  end

  # describe 'check in pages that' do
  #   let(:contents) do
  #     site.process
  #     filename = File.join('_site', 'test.html')
  #     File.read(filename)
  #   end
  #
  #   it 'after block works' do
  #     assert_equal 1, contents.scan(/(?=after block success)/).count
  #     assert_equal 0, contents.scan(/(?=after block failure)/).count
  #   end
  #
  #   it 'before block works' do
  #     assert_equal 1, contents.scan(/(?=before block success)/).count
  #     assert_equal 0, contents.scan(/(?=before block failure)/).count
  #   end
  #
  #   it 'after for_hours block works' do
  #     assert_equal 1, contents.scan(/(?=after for_hours block success)/).count
  #     assert_equal 0, contents.scan(/(?=after for_hours block failure)/).count
  #   end
  #
  #   it 'before for_hours block works' do
  #     assert_equal 1, contents.scan(/(?=before for_hours block success)/).count
  #     assert_equal 0, contents.scan(/(?=before for_hours block failure)/).count
  #   end
  #
  #   it 'before filter works' do
  #     assert_equal 3, contents.scan(/(?=before filter success)/).count
  #   end
  #
  #   it 'after filter works' do
  #     assert_equal 2, contents.scan(/(?=after filter success)/).count
  #   end
  #
  #   it 'before for_hours filter works' do
  #     assert_equal 3, contents.scan(/(?=before for_hours filter success)/).count
  #     assert_equal 0, contents.scan(/(?=before for_hours filter failure)/).count
  #   end
  #
  #   it 'after for_hours filter works' do
  #     assert_equal 2, contents.scan(/(?=after for_hours filter success)/).count
  #     assert_equal 0, contents.scan(/(?=after for_hours filter failure)/).count
  #   end
  #
  # end
  #
  # describe 'check in posts that after block' do
  #
  #   let(:contents) do
  #     site.process
  #     filename = File.join('_site', 'blog', 'after.html')
  #     File.read(filename)
  #   end
  #
  #   it 'works' do
  #     assert_equal 1, contents.scan(/(?=after block success)/).count
  #   end
  #
  # end
  #
  # describe 'check in posts that before block' do
  #
  #   let(:contents) do
  #     site.process
  #     filename = File.join('_site', 'blog', 'before.html')
  #     File.read(filename)
  #   end
  #
  #   it 'works' do
  #     assert_equal 1, contents.scan(/(?=before block success)/).count
  #   end
  #
  # end
end
