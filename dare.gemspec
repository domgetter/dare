
Gem::Specification.new do |spec|

  spec.name = 'dare'
  spec.version = '0.0.2'
  spec.date = '2014-12-04'
  spec.summary = 'Ruby Web Game library on top of Opal'
  spec.authors = ["Dominic Muller"]
  spec.email = 'nicklink483@gmail.com'
  spec.files = []

  spec.add_runtime_dependency 'opal', '= 0.6.3'
  spec.add_development_dependency 'rspec', '~> 3.0', '>=3.0.0'
  spec.add_development_dependency 'pry', '~> 0.10', '>=0.10.1'
  spec.add_development_dependency 'coveralls', '~> 0.7', '>=0.7.2'
  spec.homepage = 'https://github.com/nicklink483/dare'
  spec.license = 'MIT'

end
