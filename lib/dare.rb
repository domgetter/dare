require 'opal-jquery'
# Dir["dare/*.rb"].each {|f| require f } # can't do this because Opal
require "dare/canvas.rb"
require "dare/font.rb"
require "dare/image.rb"
require "dare/keyboard_constants.rb"
require "dare/sound.rb"
require "dare/sprite.rb"
require "dare/window.rb"

module Dare

  # returns the current version of this gem
  VERSION = "0.1.0"

  # returns the magnitude of the horizontal component of a vector
  # at some angle and some magnitude where the angle is in degrees
  # starting on the unit circle pointing to the right and going
  # counterclockwise
  # e.g.
  # Dare.offset_x(90, 10) # returns 0
  # Dare.offset_x(45, 10) # returns 10 times the square root of 2
  #
  def self.offset_x(angle, magnitude)
    `#{magnitude}*Math.cos(-#{angle}*Math.PI/180.0)`
  end

  # returns the magnitude of the vertical component of a vector
  # at some angle and some magnitude where the angle is in degrees
  # starting on the unit circle pointing to the right and going
  # counterclockwise
  # e.g.
  # Dare.offset_y(90, 10) # returns 10
  # Dare.offset_y(45, 10) # returns 10 times the square root of 2
  #
  def self.offset_y(angle, magnitude)
    `#{magnitude}*Math.sin(-#{angle}*Math.PI/180.0)`
  end

  # returns the number of milliseconds since the Unix epoch
  # useful for delta physics
  #
  def self.ms
    `(new Date()).getTime()`
  end
  class << self
    attr_accessor :default_canvas
  end
end