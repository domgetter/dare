module Dare
  class Color
    attr_accessor :red, :green, :blue
    def initialize(color)

    end
  end
  class Window

    attr_reader :width, :height, :ticks, :mouse_x, :mouse_y, :canvas, :key, :update_interval

    # Creates a new window object to hold all your game goodness
    #
    # @param [Hash] opts the options to create a window.
    # @options opts [Integer] :width (640) sets default canvas to a particular width in pixels
    # @options opts [Integer] :height (480) sets default canvas to a particular height in pixels
    # @options opts [Float] :update_interval (16.666666) sets the update interval in milliseconds between updates
    # @options opts [Boolean] :border (false) draws a border around the default canvas
    # @options opts [Dare::Canvas] :canvas (Dare.default_canvas) a canvas to refer to when drawing.
    # @options opts [Boolean] :mouse (true) turn off mouse event listeners by setting to false
    #
    def initialize(opts = {})
      opts[:width] ||= 640
      opts[:height] ||= 480
      opts[:update_interval] ||= 16.666666
      opts[:border] ||= false
      opts[:canvas] ||= Canvas.new(width: opts[:width], height: opts[:height], border: opts[:border])
      opts[:mouse] ||= true
      @width = opts[:width]
      @height = opts[:height]
      @update_interval = opts[:update_interval]
      @clock = opts[:clock]
      @canvas = opts[:canvas]
      Dare.default_canvas ||= @canvas
      @keys = []
      add_mouse_event_listener if opts[:mouse]
      add_keyboard_event_listeners
    end

    # starts the game loop for the window.
    def run!
      %x{
        function anim_loop() {
          requestAnimationFrame(anim_loop);
          #{update};
          #{@canvas.context}.clearRect(0, 0, #{width}, #{height});
          #{draw};
        }
        requestAnimationFrame(anim_loop);
      }
    end

    # gets run every frame of animation
    # override this in your subclass of Dare::Window
    def draw

    end

    # gets run every update_interval if it can
    # override this in your subclass of Dare::Window
    def update

    end

    # adds mousemove event listener to main canvas
    def add_mouse_event_listener
      Element.find("##{@canvas.id}").on :mousemove do |event|
        coords = get_cursor_position(event)
        @mouse_x = coords.x[:x]
        @mouse_y = coords.x[:y]
      end
    end

    # adds keyboard event listeners to entire page
    def add_keyboard_event_listeners
      Element.find("html").on :keydown do |event|
        @keys[get_key_id(event)] = true
      end
      Element.find("html").on :keyup do |event|
        @keys[get_key_id(event)] = false
      end
      ::Window.on :blur do |event|
        @keys.fill false
      end
    end

    # checks to see if button passed is currently being pressed
    def button_down?(button)
      @keys[button]
    end

    # sets mouse_x and mouse_y to current mouse positions relative
    # to the main canvas
    def get_cursor_position(event)
      if (event.page_x && event.page_y)
        x = event.page_x
        y = event.page_y
      else
        doc = Opal.Document[0]
        x = event[:clientX] + doc.scrollLeft +
              doc.documentElement.scrollLeft
        y = event[:clientY] + doc.body.scrollTop +
              doc.documentElement.scrollTop
      end
      x -= `#{@canvas.canvas}.offsetLeft`
      y -= `#{@canvas.canvas}.offsetTop`
      Coordinates.new(x: x, y: y)
    end

    # retrieves key code of current pressed key for keydown or keyup event
    def get_key_id(event)
      event[:keyCode]
    end

    # draws a rectangle starting at (top_left[0], top_left[1])
    # down to (top_left[0]+width, top_left[1]+height)
    def draw_rect(opts = {})
      x = opts[:top_left][0]
      y = opts[:top_left][1]
      width = opts[:width]
      height = opts[:height]
      color = opts[:color]

      `#{@canvas.context}.fillStyle = #{color}`
      `#{@canvas.context}.fillRect(#{x}, #{y}, #{width}, #{height})`
    end

    #works the same as Gosu::Window.draw_quad
    def draw_quad(x1, y1, c1, x2, y2, c2, x3, y3, c3, x4, y4, c4, z)
      %x{
        var QUALITY = 256;

        var canvas_colors = document.createElement( 'canvas' );
        canvas_colors.width = 2;
        canvas_colors.height = 2;

        var context_colors = canvas_colors.getContext( '2d' );
        context_colors.fillStyle = 'rgba(0,0,0,1)';
        context_colors.fillRect( 0, 0, 2, 2 );

        var image_colors = context_colors.getImageData( 0, 0, 2, 2 );
        var data = image_colors.data;

        var canvas_render = #{@canvas};

        var context_render = #{@canvas.context};
        context_render.translate( - QUALITY / 2, - QUALITY / 2 );
        context_render.scale( QUALITY, QUALITY );

        data[ 0 ] = 255; // Top-left, red component
        data[ 5 ] = 255; // Top-right, green component
        data[ 10 ] = 255; // Bottom-left, blue component

        context_colors.putImageData( image_colors, 0, 0 );
        context_render.drawImage( canvas_colors, 0, 0 );
      }
    end

    # sets the caption/title of the window to the string passed
    def caption(title)
      `document.getElementById('pageTitle').innerHTML = #{title}`
    end

    # checks if game is fullscreen.  currently not implemented.
    def fullscreen?
      false
    end

    # this is here for Gosu API compatability
    def text_input; end

  end
  class Coordinates < Struct.new(:x, :y); end
end