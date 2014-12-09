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

    > dare new gamename
        create  gamename/Gemfile
        create  gamename/Rakefile
        create  gamename/gamename.rb
        create  gamename/gamename.html
    > cd gamename
    gamename> rake build
    gamename>

Which will create a game.js file and an game.html file.  Open game.html in your favorite browser, and play your game!

Of course, your game doesn't *do* anything yet.

Open up game.rb and add a rectangle to draw every frame:

```ruby
class Game < Dare::Window
  #...
  def draw
    draw_rect(top_left: [0,0], width: 50, height: 50, color: 'red') #API subject to change
  end
  #...
end
```
Save it, run `rake build` again, and refresh your game.html!  There's a red square there!  That's so cool!

Just keep in mind the "change ruby code" => "rake build" => "refresh browser" development cycle.  This can be shortened to "change ruby code" => "refresh browser" if you set up guard, but I'll save that for the future.  If you already know how, feel free to set that up!

TODO:

1. Figure out Opal-rspec stuff

2. documentation

Huge shoutout to jlnr for his [Gosu](https://github.com/jlnr/gosu) gem which fueled a major part of this API.  Go check out his work!
