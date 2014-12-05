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