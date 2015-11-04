require 'jekyll/data_validation/validator'
require 'jekyll/data_validation/error_generator'
require 'jekyll/data_validation/formats/short_date'
require 'jekyll/data_validation/formats/short_time'
require 'jekyll/data_validation/formats/short_date_time'

Jekyll::DataValidation::Formats::ShortDate.new
Jekyll::DataValidation::Formats::ShortTime.new
Jekyll::DataValidation::Formats::ShortDateTime.new
