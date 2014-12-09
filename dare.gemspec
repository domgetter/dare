lib = File.expand_path File.join(File.dirname(__FILE__), 'lib')
$:.unshift lib unless $:.include?(lib)

require 'bundler'

Gem::Specification.new do |spec|

  spec.name = 'dare'
  spec.version = '0.0.9'
  spec.date = '2014-12-08'
  spec.summary = 'Ruby 2D Game library on top of Opal'
  spec.authors = ["Dominic Muller"]
  spec.email = 'nicklink483@gmail.com'
  spec.files = Dir['bin/dare', 'lib/*/**', 'lib/*.*']
  spec.executables = ["dare"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'opal', '0.5.5'
  spec.add_runtime_dependency 'opal-jquery', '0.2.0'
  spec.add_development_dependency 'opal-rspec', '0.2.1'
  spec.add_development_dependency 'pry', '~> 0.10', '>=0.10.1'
  spec.add_development_dependency 'coveralls', '~> 0.7', '>=0.7.2'
  spec.homepage = 'https://github.com/nicklink483/dare'
  spec.license = 'MIT'

end
