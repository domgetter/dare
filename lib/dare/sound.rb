module Dare
  class Sound

    def initialize(path)
      `var snd = new Audio(#{path})`
      `snd.volume = 0.3`
      @file = `snd`
    end

    def play
      %x{
        #{@file}.play();
      }
    end
  end
end