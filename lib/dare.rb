require 'dare/clock.rb'
require 'dare/sound.rb'
require 'dare/font.rb'
require 'dare/sprite.rb'
require 'dare/window.rb'

module Dare
  VERSION = "0.0.8"
  def self.offset_x(angle, magnitude)
    `#{magnitude}*Math.cos(#{angle}*Math.PI/180.0)`
  end
  def self.offset_y(angle, magnitude)
    `#{magnitude}*Math.sin(#{angle}*Math.PI/180.0)`
  end
  def self.ms
    `(new Date()).getTime()`
  end
end