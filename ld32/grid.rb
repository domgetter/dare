#rows and columns of vertices
#verts have x,y, and up to 4 outbound connections
class Grid
  attr_reader :width, :height, :vertices, :cell_draw_size
  
  def initialize(game, opts = {})
    @game = game
    @width = opts[:width]
    @height = opts[:height]
    @vertices = []
    @cell_draw_size = opts[:cell_draw_size]
    right = true
    left = true
    down = true
    up = true
    (1..@height).each do |y|
      (1..@width).each do |x|
        right = !(x == @width)
        left = !(x == 1)
        down = !(y == @height)
        up = !(y == 1)
        
        @vertices << Vertex.new(@game, x*@cell_draw_size, y*@cell_draw_size, right: right, left: left, up: up, down: down)
      end
    end
  end
  
  def draw
    @vertices.each &:draw
  end
  
  def vertex_to_right_of(vertex)
    if (vertex.right)
      @vertices[@vertices.index(vertex) + 1]
    else
      nil
    end
  end
  
  def vertex_to_left_of(vertex)
    if (vertex.left)
      @vertices[@vertices.index(vertex) - 1]
    else
      nil
    end
  end
  
  def vertex_below(vertex)
    if (vertex.down)
      @vertices[@vertices.index(vertex) + @width]
    else
      nil
    end
  end
  
  def vertex_above(vertex)
    if (vertex.up)
      @vertices[@vertices.index(vertex) - @width]
    else
      nil
    end
  end
end