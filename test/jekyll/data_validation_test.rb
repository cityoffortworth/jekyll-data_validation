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

  describe 'user-date format' do
    it 'allows quoted user-date' do
      assert_no_errors 'user_date'
    end

    it 'creates error for invalid user-date' do
      assert_has_errors 'user_date_bad_month'
    end

    it 'creates error for user-date without quotes' do
      assert_has_errors 'user_date_no_quotes'
    end

    it 'creates error if user-date has wrong format' do
      assert_has_errors 'user_date_with_wrong_user_time_format'
      assert_has_errors 'user_date_with_wrong_user_date_time_format'
    end
  end

  describe 'user-time format' do
    it 'allows quoted user-time' do
      assert_no_errors 'user_time'
    end

    it 'creates error for invalid user-time' do
      assert_has_errors 'user_time_bad_hours'
    end

    it 'creates error for user-time without quotes' do
      assert_has_errors 'user_time_no_quotes'
    end

    it 'creates error if user-time has wrong format' do
      assert_has_errors 'user_time_with_wrong_user_date_format'
      assert_has_errors 'user_time_with_wrong_user_date_time_format'
    end
  end

  describe 'user-date-time format' do
    it 'allows quoted user-date-time' do
      assert_no_errors 'user_date_time'
    end

    it 'creates error for invalid user-date-time' do
      assert_has_errors 'user_date_time_bad_month'
      assert_has_errors 'user_date_time_bad_hours'
    end

    it 'creates error for user-date-iime without quotes' do
      # Unfortunately there's no way to determine this, the YAML parser
      # returns a String regardless if a user-date-time is quoted or not.
      # assert_has_errors 'user_date_time_no_quotes'
    end

    it 'creates error if user-date-time has wrong format' do
      assert_has_errors 'user_date_time_with_wrong_user_date_format'
      assert_has_errors 'user_date_time_with_wrong_user_time_format'
    end
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
      error[:problems].each do |problem|
        errors_count += 1 if problem[:message].include?("'#/#{fieldname}'")
      end
    end
    errors_count
  end

  def swallow_stdout
    old_stdout = $stdout
    $stdout = StringIO.new('','w')
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end
