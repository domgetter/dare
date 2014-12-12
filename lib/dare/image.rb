module Dare

  # loads an image which can be drawn to a canvas
  #
  class Image

    # loads a new image resource
    # image = Dare::Image.new('some_image.png')
    #
    def initialize(path = "", canvas = Dare.default_canvas)
      @img = `new Image()`
      `#{@img}.src = #{path}`
      @canvas = canvas
    end

    # draws image to a canvas at an x and y position
    # x and y represent the top-left corner of the image
    # image.draw(100, 200)
    #
    # by default, the default canvas is drawn to, but this
    # can be bypassed by specifying a different canvas to
    # draw to in the options hash
    #
    # image.draw(100, 200, canvas: some_other_canvas)
    #
    def draw(x = 0, y = 0, opts = {})
      opts[:canvas] ||= @canvas
      `#{opts[:canvas].context}.drawImage(#{@img},#{x},#{y})`
    end
  end
end