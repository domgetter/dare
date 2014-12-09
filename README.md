dare
====
[![Gem Version](https://badge.fury.io/rb/dare.svg)](http://badge.fury.io/rb/dare)
[![Build Status](https://travis-ci.org/nicklink483/dare.svg?branch=master)](https://travis-ci.org/nicklink483/dare)
[![Coverage Status](https://coveralls.io/repos/nicklink483/dare/badge.png)](https://coveralls.io/r/nicklink483/dare)
[![Dependency Status](https://gemnasium.com/nicklink483/dare.svg)](https://gemnasium.com/nicklink483/dare)
[![Code Climate](https://codeclimate.com/github/nicklink483/dare/badges/gpa.svg)](https://codeclimate.com/github/nicklink483/dare)

**This Gem is still in alpha! Breaking and changes are expected everywhere!**

Ruby Web Game library on top of Opal

    gem install dare

and then

    dare new game
    cd game
    rake build

Which will create a game.js file and an game.html file.  Open game.html in your favorite browser, and play your game!

Of course, your game doesn't *do* anything yet.

Open up game.rb and add a rectangle to draw every frame:

    class Game < Dare::Window
      #...
      def draw
        draw_rect(0,0,50,50)
      end
      #...
    end

Save it, run `rake build` again, and refresh your game.html!

TODO:

1. Figure out Opal-rspec stuff

2. documentation

Huge shoutout to jlnr for his [Gosu](https://github.com/jlnr/gosu) gem which fueled a major part of this API.  Go check out his work!