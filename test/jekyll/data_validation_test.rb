require 'jekyll'
require 'jekyll/data_validation'
require 'minitest/autorun'

describe Jekyll::DataValidation do

  def setup
    config = Jekyll.configuration({
      'config' => 'test/fixtures/_config.yml',
      'quiet' => true
    })
    validator = Jekyll::DataValidation::Validator.new(config)
    @errors = validator.validate
  end

  it 'allows quoted short date' do
    assert_no_errors 'short_date'
  end

  it 'allows quoted short time' do
    assert_no_errors 'short_time'
  end

  it 'allows quoted short date time' do
    assert_no_errors 'short_date_time'
  end

  it 'creates error for invalid short date' do
    assert_has_errors 'short_date_bad_month'
  end

  it 'creates error for invalid short time' do
    assert_has_errors 'short_time_bad_hours'
  end

  it 'creates error for invalid short date time' do
    assert_has_errors 'short_date_time_bad_month'
    assert_has_errors 'short_date_time_bad_hours'
  end

  it 'creates error for short date without quotes' do
    assert_has_errors 'short_date_no_quotes'
  end

  it 'creates error for short time without quotes' do
    assert_has_errors 'short_time_no_quotes'
  end

  it 'creates error for short date time without quotes' do
    # Unfortunately there's no way to determine this, the YAML parser
    # returns a String regardless if a short date time is quoted.
    # assert_has_errors 'short_date_time_no_quotes'
  end

  it 'creates error if short date has wrong format' do
    assert_has_errors 'short_date_with_wrong_short_time_format'
    assert_has_errors 'short_date_with_wrong_short_date_time_format'
  end

  it 'creates error if short time has wrong format' do
    assert_has_errors 'short_time_with_wrong_short_date_format'
    assert_has_errors 'short_time_with_wrong_short_date_time_format'
  end

  it 'creates error if short date time has wrong format' do
    assert_has_errors 'short_date_time_with_wrong_short_date_format'
    assert_has_errors 'short_date_time_with_wrong_short_time_format'
  end

  private

  def assert_no_errors(fieldname)
    assert_equal 0, count_errors(fieldname)
  end

  def assert_has_errors(fieldname)
    assert_equal 1, count_errors(fieldname)
  end

  def count_errors(fieldname)
    errors_count = 0
    @errors.each do |error|
      errors_count += 1 if error[:messages].any? do |message|
        message.include?("'#/#{fieldname}'")
      end
    end
    errors_count
  end

end
