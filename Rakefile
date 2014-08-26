#require "bundler/gem_tasks"
#require 'rspec/core/rake_task'
#if defined? RSpec
#  task(:spec).clear
#  RSpec::Core::RakeTask.new(:spec) do |t|
#    t.verbose = false
#  end
#end
#task default: :spec

require 'jquery'
require 'opal/rspec/rake_task'
require 'opal-jquery'
Opal::RSpec::RakeTask.new(:default) do |t|
  t.append_path 'lib'
end
