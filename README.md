![Dare Logo](/images/logo.png) Dare
====
[![Gem Version](https://badge.fury.io/rb/dare.svg)](http://badge.fury.io/rb/dare)
[![Build Status](https://travis-ci.org/domgetter/dare.svg?branch=master)](https://travis-ci.org/domgetter/dare)
[![Dependency Status](https://gemnasium.com/nicklink483/dare.svg)](https://gemnasium.com/nicklink483/dare)
[![Code Climate](https://codeclimate.com/github/nicklink483/dare/badges/gpa.svg)](https://codeclimate.com/github/nicklink483/dare)

**This Gem is still in alpha! Breaking and changes are expected everywhere!**

Ruby Web Game library on top of Opal

## Installation

```bash
$ gem install dare
```

and then

```bash
$ dare new gamename
    create  gamename/Gemfile
    create  gamename/Rakefile
    create  gamename/gamename.rb
    create  gamename/gamename.html
$ cd gamename
gamename$ rake build
gamename$
```

Which will create a game.js file and an game.html file.  Open game.html in your favorite browser, and play your game!

## Usage

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

### Keyboard and Mouse input

You can respond to user input with a couple of helper methods
Change just a few lines in your app.rb file

```ruby
class Game < Dare::Window

  def initialize
    super width: 800, height: 600, border: true
    #lets add an instance variable to store where our box is
    @x = 10
  end

  def draw
    # if the right arrow is being held down, add 5 to the position
    if button_down? Dare::KbRight
      @x += 5
    end
    # if the position gets too large, reset it
    if @x > 600
      @x = 10
    end
    @y = mouse_y # mouse_y is a helper method which returns the y-position off the mouse
    #be sure to set the x position to @x and the y position to @y in the draw_rect method!
    draw_rect(top_left: [@x,@y], width: 50, height: 50, color: 'red')
  end

end
```

Now `rake build`, refresh the browser, and voila!  You can press the right arrow on your keyboard, and the box will move to the right!  Move your mouse up and down and watch your box rise and fall!

### Images and Sound

Adding images and sound is straightforward:


```ruby
class Game < Dare::Window

  def initialize
    super width: 800, height: 600, border: true
    @meow = Dare::Sound.new('meow.mp3', volume: 0.5)
    @cat_picture = Dare::Image.new('cat_picture.jpg')
    @x = 10
  end

  def draw
    if button_down? Dare::KbRight
      @x += 5
    end
    if @x > 600
      @x = 10
    end
    @cat_picture.draw(@x, 20)
  end

  def update
    if @x > 500
      @meow.play
    end
  end

end
```

Now if you have a meow.mp3 file and a cat_picture.jpg file in the same directory as your html file, they will get loaded and played just like that!

## More

To see more, go follow the [tutorial in the wiki](https://github.com/nicklink483/dare/wiki/Ruby-Tutorial)!  I'm constantly adding new features, so be sure to check back often!

And go make a game!

## Attribution

Huge shoutout to jlnr for his [Gosu](https://github.com/jlnr/gosu) gem which fueled a major part of this API.  Go check out his work!
