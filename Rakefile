require 'opal'
require 'opal-jquery'

desc "Build example.js"
task :build do
  env = Opal::Environment.new
  env.append_path "lib"
  env.append_path "examples"

  File.open("examples/example.js", "w+") do |out|
    out << env["example"].to_s
  end
end