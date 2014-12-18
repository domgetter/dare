lib = File.expand_path File.join(File.dirname(__FILE__), 'lib')
$:.unshift lib unless $:.include?(lib)

require 'bundler'

Gem::Specification.new do |spec|

  spec.name = 'dare'
  spec.version = '0.1.3'
  spec.date = '2014-12-17'
  spec.summary = 'Ruby 2D Game library on top of Opal'
  spec.authors = ["Dominic Muller"]
  spec.email = 'nicklink483@gmail.com'
  spec.files = Dir['bin/dare', 'lib/dare/*.rb', 'lib/*.rb', 'examples/tutorial/*/**']
  spec.executables = ["dare"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rake', '10.4.2'
  spec.add_runtime_dependency 'opal', '0.7.0.beta3'
  spec.add_runtime_dependency 'opal-jquery', '0.3.0.beta1'
  spec.add_runtime_dependency 'thor', '0.19.1'

  spec.add_development_dependency 'opal-rspec', '0.4.0.beta4'
  spec.add_development_dependency 'pry', '~> 0.10', '>=0.10.1'

  spec.homepage = 'https://github.com/nicklink483/dare'
  spec.license = 'MIT'

end
