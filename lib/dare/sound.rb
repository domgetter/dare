module Dare

  # wrapper for JS Audio
  # takes a path/uri as an argument
  # e.g. song = Dare::Sound.new('my_song.mp3')
  # song.play will then play the mp3 in the browser
  #
  class Sound

    # loads an audio resource from a path
    # Sound.new('http://www.some-site.com/song.mp3')
    # Sound.new('local_song_in_same_directory_of_app_js_file.mp3')
    # a predefined volume may be passed as a second parameter
    # Sound.new('file.mp3', 0.5)
    def initialize(path, volume = 1)
      `var snd = new Audio(#{path})`
      `snd.volume = #{volume}`
      @sound = `snd`
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
      `#{@sound}.play()`
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