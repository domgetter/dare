desc "Build example.js"
task :dare do
  require 'opal'
  require 'opal-jquery'
  env = Opal::Environment.new
  env.append_path "lib"
  env.append_path "examples"

  File.open("examples/example.js", "w+") do |out|
    out << env["example"].to_s
  end
end

require "bundler/gem_tasks"
require 'rspec/core/rake_task'
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end
task default: :spec