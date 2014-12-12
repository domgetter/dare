module Dare
  class Window

    attr_reader :width, :height, :ticks, :mouse_x, :mouse_y, :canvas, :key, :update_interval

    # creates a new window object to hold all your game goodness
    # options include:
    #  :width # (default 640) sets default canvas to a particular width in pixels
    #  :height # (default (480) sets default canvas to a particular height in pixels
    #  :update_interval # (default 16.666666) sets the update interval in milliseconds between updates
    #  :border # true/false (default false) draws a border around the default canvas
    #  :canvas # a canvas to refer to when drawing.  Just let the default do its thing
    #  :mouse # true/false (default true) turn off mouse event listeners by setting to false
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