Gem::Specification.new do |spec|

  spec.name          = 'jekyll-data_validation'
  spec.version       = '0.0.1'
  spec.authors       = ['Greg Scott']
  spec.email         = ['me@gregoryjscott.com']
  spec.summary       = %q{Uses JSON Schema to validate data in Jekyll pages, posts, and data.}
  spec.homepage      = 'https://github.com/cityoffortworth/jekyll-data_validation'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json-schema', '~> 2.5'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'jekyll', '~> 2.5'
  spec.add_development_dependency 'minitest', '~> 5.8.1'

end
