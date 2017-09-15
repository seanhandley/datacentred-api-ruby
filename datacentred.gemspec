Gem::Specification.new do |gem|
  gem.name        = 'datacentred'
  gem.version     = '1.1.1pre'
  gem.date        = '2017-09-14'
  gem.summary     = 'datacentred'
  gem.description = 'Gem wrapper for Datacentred API'
  gem.authors     = [ 'Eugenia Grieff', 'Sean Handley' ]
  gem.email       = 'megrieff@gmail.com'
  gem.files       = `git ls-files`.split("\n")
  gem.homepage    = 'https://github.com/datacentred/datacentred-api-ruby'
  gem.license     = 'MIT'

  gem.required_ruby_version = '> 2.3'

  # Runtime Dependencies
  gem.add_runtime_dependency 'faraday',               '~> 0.9.1'
  gem.add_runtime_dependency 'recursive-open-struct', '~> 1.0'

  # Development Dependencies
  gem.add_development_dependency 'minitest',  '~> 5.3.1'
  gem.add_development_dependency 'rake',      '~> 12.0.0'
  gem.add_development_dependency 'vcr',       '~> 2.8.0'
  gem.add_development_dependency 'webmock',   '~> 1.8.0'
  gem.add_development_dependency 'yard',      '~> 0.9.0'
  gem.add_development_dependency 'coveralls', '~> 0.8.0'
end
