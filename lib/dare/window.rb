module Dare
  class Canvas
    attr_reader :id, :canvas
    def initialize(opts = {})
      opts[:width] ||= 640
      opts[:height] ||= 480
      `var my_canvas = document.createElement("canvas")`
      @id = rand(36**8).to_s(36)
      `my_canvas.setAttribute('id', #{@id})`
      `my_canvas.width = #{opts[:width]}`
      `my_canvas.height = #{opts[:height]}`
      `document.body.appendChild(my_canvas)`
      @canvas = `my_canvas`
    end
    def context
      `#{@canvas}.getContext('2d')`
    end
  end
  class Window
    attr_reader :width, :height, :ticks, :mouse_x, :mouse_y
    def initialize(opts = {})
      opts[:width] ||= 640
      opts[:height] ||= 480
      opts[:update_interval] ||= 16.6666666
      opts[:clock] ||= Clock.new(update_interval: opts[:update_interval])
      @width = opts[:width]
      @height = opts[:height]
      @clock = opts[:clock]
      @ticks = 0
      @canvas = Canvas.new(width: @width, height: @height)
      add_mouse_event_listener
    end
    def run!
      @clock.start do
        update
        `#{@canvas.context}.clearRect(0, 0, #{width}, #{height})`
        draw
      end
    end
    def update
      @ticks += 1
    end
    def stop!
      @clock.stop
    end

    def add_mouse_event_listener
      Element.find("##{@canvas.id}").on :mousemove do |event|
        coords = get_cursor_position(event)
        @mouse_x = coords.x[:x]
        @mouse_y = coords.x[:y]
      end
    end

    def get_cursor_position(event)
      if (event.page_x && event.page_y)
        x = event.page_x;
        y = event.page_y;
      else
        doc = Opal.Document[0]
        x = event[:clientX] + doc.scrollLeft +
              doc.documentElement.scrollLeft;
        y = event[:clientY] + doc.body.scrollTop +
              doc.documentElement.scrollTop;
      end
      x -= `#{@canvas.canvas}.offsetLeft`
      y -= `#{@canvas.canvas}.offsetTop`
      Coordinates.new(x: x, y: y)
    end

    def draw_rect(opts = {})
      x = opts[:top_left][0]
      y = opts[:top_left][1]
      width = opts[:width]
      height = opts[:height]
      color = opts[:color]

      `#{@canvas.context}.beginPath()`
      `#{@canvas.context}.rect(#{x}, #{y}, #{width}, #{height})`
      `#{@canvas.context}.fillStyle = #{color}`
      `#{@canvas.context}.fill()`
    end

  end
  class Coordinates < Struct.new(:x, :y); end
end