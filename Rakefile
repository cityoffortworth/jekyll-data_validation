require 'rake/testtask'
require 'jekyll/data_validation'

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
