module Dare

  # wrapper for JS Audio
  # takes a path/uri as an argument
  # e.g. song = Dare::Sound.new('my_song.mp3')
  # song.play will then play the mp3 in the browser
  #
  class Sound

    # loads an audio resource from a path
    # Sound.new('http://www.google.com/song.mp3')
    # Sound.new('local_song_in_same_directory_of_app_js_file.mp3')
    # a predefined volume may be passed as an option
    # Sound.new('file.mp3', volume: 0.5)
    #
    def initialize(path, opts = {})
      opts[:overlap] ||= 1
      opts[:volume] ||= 1
      opts[:overlap] = 1 if opts[:overlap].to_i < 1
      opts[:overlap] = 10 if opts[:overlap].to_i > 10
      @overlap = opts[:overlap]
      @sounds = []
      @overlap.times do
        `var snd = new Audio(#{path})`
        `snd.volume = #{opts[:volume]}`
        @sounds << `snd`
      end
      @sound = 0
    end

    # set the volume of the audio resource to value between 0 and 1
    #
    def volume=(vol)
      `#{@sound}.volume = #{vol}`
    end

    # retrieve the current volume of the audio resource
    #
    def volume
      `#{@sound}.volume`
    end

    # play the audio resource in the window/tab it was created in
    # if resource was paused, it will start playing from where it left off
    #
    def play
      @sound += 1
      @sound %= @overlap
      `#{@sounds[@sound]}.play()`
    end

    # pause the audio resource, halting playback
    #
    def pause
      `#{@sound}.pause()`
    end

    # seek to particular time in playback.  Time passed is in seconds.
    #
    def time=(time)
      `#{@sound}.currentTime = #{time}`
    end
  end
end