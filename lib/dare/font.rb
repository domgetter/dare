module Dare
  class Font
    def initialize(opts = {})
      opts[:font] ||= "Arial"
      opts[:canvas] ||= Dare.default_canvas
      opts[:size] ||= 30
      opts[:color] ||= "black"

      @font = opts[:size].to_s + "px" + " " + opts[:font]
      @canvas = opts[:canvas]
      @color = opts[:color]
    end

    def draw(string = "", x = 0, y = 0, opts = {})
      %x{
        #{@canvas.context}.font = #{@font} ;
        #{@canvas.context}.textAlign = 'left';
        #{@canvas.context}.textBaseline = 'top';
        #{@canvas.context}.fillStyle = #{@color};
        #{@canvas.context}.fillText(#{string}, #{x}, #{y});
      }
    end
  end
end