dare
====
[![Gem Version](https://badge.fury.io/rb/dare.svg)](http://badge.fury.io/rb/dare)
[![Build Status](https://travis-ci.org/nicklink483/dare.svg?branch=master)](https://travis-ci.org/nicklink483/dare)
[![Coverage Status](https://coveralls.io/repos/nicklink483/dare/badge.png)](https://coveralls.io/r/nicklink483/dare)
[![Dependency Status](https://gemnasium.com/nicklink483/dare.svg)](https://gemnasium.com/nicklink483/dare)
[![Code Climate](https://codeclimate.com/github/nicklink483/dare/badges/gpa.svg)](https://codeclimate.com/github/nicklink483/dare)

**This Gem is still in alpha! Breaking and changes are expected everywhere!**

Note: **None of the following works yet.**

Ruby Web Game library on top of Opal

    gem install dare

Save this to some_file.rb:

    require 'dare'

    class Game < Window

      def initialize
        super 640, 480
      end

    end

    Game.new

And then from the command line:

    dare build some_file.rb

Which will create a some_file.js file and an index.html file.  Open index.html in your favorite browser, and play your game!

TODO:

1. Figure out Opal-rspec stuff
2. make it so `dare new app_name` makes a few useful files in a directory
  a. like this:

    create app_name
    create app_name/Gemfile
    create app_name/Rakefile
    create app_name/app_name.rb
    create app_name/app_name.html

  b. where Gemfile contains

    gem 'dare', '0.0.2 or whatever version'

  and Rakefile contains

    desc "Build app_name.js"
    task :build do
      require 'opal'
      env = Opal::Environment.new
      env.append_path "."
      env.append_path `bundle show dare`.chomp

      File.open("app_name.js", "w+") do |out|
        out << env["app_name"].to_s
      end
    end

  and app_name.rb contains

    require 'dare'

    class AppName < Dare::Window

      def initialize
        super width: 640, height: 480
      end

      def draw
        #code that runs every frame
      end

      def update
        #code that runs every frame
      end

    end

  and app_name.html contains

    <!DOCTYPE html>
    <html>
      <head>
        <script src="http://cdn.opalrb.org/opal/0.6.3/opal.min.js"></script>
      </head>
      <body>
        <script src="app_name.js"></script>
      </body>
    </html>

  or something like that.

3. documentation

Huge shoutout to jlnr for his [Gosu](https://github.com/jlnr/gosu) gem which fueled a major part of this API.  Go check out his work!