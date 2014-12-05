require "bundler/gem_tasks"
require 'rspec/core/rake_task'
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end
task default: :spec
