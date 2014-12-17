module Dare

  # Represents an image which can be drawn to a canvas
  #
  class Image

    # Loads a new image resource from an absolute URL or relative path
    #
    # @param [String] path ("") the path to the resource
    # @param [Hash] opts ({}) the options to create an image.
    # @option opts [Dare::Canvas] :canvas (Dare.default_canvas) a canvas to refer to when drawing.
    #
    # @example
    #   Dare::Image.new('some_image.png')
    #
    # @example
    #   Dare::Image.new('https://www.google.com/images/srpr/logo11w.png', canvas: Dare::Canvas.new)
    #
    def initialize(path = "", opts = {})
      opts[:canvas] ||= Dare.default_canvas
      @path = path
      @img = `new Image()`
      `#{@img}.src = #{path}`
      @canvas = opts[:canvas]
    end

    # The path or URL of the image
    #
    # @return [String]
    #
    def path
      @path
    end

    # The width of the image in pixels
    #
    # @return [Integer]
    #
    def width
      `#{@img}.width`
    end

    # The height of the image in pixels
    #
    # @return [Integer]
    #
    def height
      `#{@img}.height`
    end

    # Draws image to a canvas at an `x` and `y` position. `x` and `y` represent the top-left corner of the image
    #
    # @param [Integer] x (0) x coordinate of top-left of image
    # @param [Integer] y (0) y coordinate of top-left of image
    # @param [Hash] opts ({}) the options to draw an image.
    # @option opts [Dare::Canvas] :canvas (Dare.default_canvas) a canvas to refer to when drawing.
    #
    # @example
    #   image.draw(100, 200)
    #
    # @example
    #   image.draw(10, 10, canvas: Dare::Canvas.new(width: 100, height: 100))
    #
    def draw(x = 0, y = 0, opts = {})

      opts[:canvas] ||= @canvas
      %x{
        #{opts[:canvas].context}.drawImage(
          #{@img},
          #{x},
          #{y}
        );
      }
    end

    # (see #draw)
    # @note Used by Dare::ImageTile to draw a portion of an image to a canvas.
    #
    def draw_tile(x = 0, y = 0, opts = {})

      opts[:canvas] ||= @canvas
      opts[:sx] ||= 0
      opts[:sy] ||= 0
      opts[:swidth] ||= width - opts[:sx]
      opts[:sheight] ||= height - opts[:sy]
      opts[:dwidth] ||= opts[:swidth]
      opts[:dheight] ||= opts[:sheight]

      %x{
        #{opts[:canvas].context}.drawImage(
          #{@img},
          #{opts[:sx]},
          #{opts[:sy]},
          #{opts[:swidth]},
          #{opts[:sheight]},
          #{x},
          #{y},
          #{opts[:dwidth]},
          #{opts[:dheight]}
        );
      }
    end

    # Draws image to a canvas at an x and y position and rotated at some angle
    # x and y represent the center of the image
    # angle is in degrees starting by pointing to the right and increasing counterclockwise
    #
    # @param [Integer] x (0) x coordinate of center of image
    # @param [Integer] y (0) y coordinate of center of image
    # @param [Float] angle (90.0) angle of image
    # @param [Hash] opts ({}) the options to draw an image.
    # @option opts [Dare::Canvas] :canvas (Dare.default_canvas) a canvas to refer to when drawing.
    #
    # @example
    #   image.draw_rot(100, 200, 45) # this will point the top of the image up and to the right
    #
    # @example
    #   image.draw_rot(50, 75, 270, canvas: some_other_canvas)
    #
    def draw_rot(x = 0, y = 0, angle = 90, opts = {})
      opts[:canvas] ||= @canvas
      %x{
        var context = #{opts[:canvas].context};
        var width = #{@img}.width;
        var height = #{@img}.height;
        context.translate(#{x}, #{y});
        context.rotate(-#{angle-90}*Math.PI/180.0);
        context.drawImage(#{@img}, -width/2, -height/2, width, height);
        context.rotate(#{angle-90}*Math.PI/180.0);
        context.translate(-#{x}, -#{y});
      }
    end

    # (see #draw_rot)
    # @note Used by Dare::ImageTile to draw a portion of an image to a canvas at an angle.
    #
    def draw_tile_rot(x = 0, y = 0, angle = 90, opts = {})
      opts[:canvas] ||= @canvas
      opts[:sx] ||= 0
      opts[:sy] ||= 0
      opts[:swidth] ||= width - opts[:sx]
      opts[:sheight] ||= height - opts[:sy]
      opts[:dwidth] ||= opts[:swidth]
      opts[:dheight] ||= opts[:sheight]
      %x{
        var context = #{opts[:canvas].context};
        context.translate(#{x}, #{y});
        context.rotate(-#{angle-90}*Math.PI/180.0);
        context.drawImage(
          #{@img},
          #{opts[:sx]},
          #{opts[:sy]},
          #{opts[:swidth]},
          #{opts[:sheight]},
          -#{opts[:swidth]}/2,
          -#{opts[:sheight]}/2,
          #{opts[:swidth]},
          #{opts[:sheight]});
        context.rotate(#{angle-90}*Math.PI/180.0);
        context.translate(-#{x}, -#{y});
      }
    end

    # Loads image and cuts it into tiles
    #
    # @param [String] path ("") the path to the resource
    # @param [Hash] opts ({}) the options to create an image.
    # @option opts [Integer] :width (Image.new(path).width) width of a single tile from the image
    # @option opts [Integer] :height (Image.new(path).height) height of a single tile from the image
    #
    # @return [Array] An array of images each of which are individual tiles of the original
    #
    def self.load_tiles(path = "", opts = {})

      image = Image.new(path)
      opts[:width] ||= image.width
      opts[:height] ||= image.height
      columns = image.width/opts[:width]
      rows = image.height/opts[:height]

      tiles = []
      rows.times do |row|
        columns.times do |column|
          tiles << ImageTile.new(image, column*opts[:width], row*opts[:height], opts[:width], opts[:height])
        end
      end
      tiles
    end
  end

  class ImageTile
    attr_reader :width, :height
    def initialize(image = Image.new, x = 0, y = 0, width = 0, height = 0)
      @image = image
      @x = x
      @y = y
      @width = width
      @height = height
    end

    def draw(x = 0, y = 0, opts = {})
      @image.draw_tile(x, y, opts.merge({sx: @x, sy: @y, swidth: @width, sheight: @height}))
    end

    def draw_rot(x = 0, y = 0, angle = 90, opts = {})
      @image.draw_tile_rot(x, y, angle, opts.merge({sx: @x, sy: @y, swidth: @width, sheight: @height}))
    end
  end
end