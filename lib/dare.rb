require 'opal'
require 'opal-jquery'
require 'dare/clock.rb'
require 'dare/window.rb'

module Dare
  def self.offset_x(angle, magnitude)
    `#{magnitude}*Math.cos(#{angle}*Math.PI/180)`
  end
  def self.offset_y(angle, magnitude)
    `#{magnitude}*Math.sin(#{angle}*Math.PI/180)`
  end
end