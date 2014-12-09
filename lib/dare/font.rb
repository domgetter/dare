module Dare
  class Font
    def initialize(window = Dare.default_window, font_type = "30px Arial")
      @window = window
      @font = font_type
      @color = "red"
      @x = 50
      @y = 50
    end

    def draw(string = "", x = @x, y = @y)
      %x{
        #{@window.canvas.context}.font = #{@font};
        #{@window.canvas.context}.fillStyle = #{@color};
        #{@window.canvas.context}.fillText(#{string}, #{x}, #{y});
      }
    end
  end
end