
#2 to 4 neighbors
# may or may not have a connecting edge to each neighbor
# a connecting edge is true for both sides.  no one-way connections, i.e. undirected graph
class Vertex
  attr_reader :x, :y
  attr_accessor :right, :left, :down, :up
  
  def initialize(game, x, y, opts = {})
    opts[:right] = true if opts[:right].nil?
    opts[:left] = true if opts[:left].nil?
    opts[:down] = true if opts[:down].nil?
    opts[:up] = true if opts[:up].nil?
    @game = game
    @x = x
    @y = y
    @right = opts[:right]
    @left = opts[:left]
    @down = opts[:down]
    @up = opts[:up]
  end
  
  def draw
    if @right
      @game.draw_line(from: [@x, @y], to: [@x+@game.grid.cell_draw_size, @y])
    end
    if @down
      @game.draw_line(from: [@x, @y], to: [@x, @y+@game.grid.cell_draw_size])
    end
    @game.draw_circle(center: [@x, @y], radius: 5, color: 'grey')
  end
  
  def neighbors
    neighbors = []
    g = @game.grid
    v = g.vertices
    neighbors << v[v.index(self) + 1] if right
    neighbors << v[v.index(self) - 1] if left
    neighbors << v[v.index(self) + g.width] if down
    neighbors << v[v.index(self) - g.width] if up
    neighbors
  end
  
  def can_have_right
    ((@game.grid.vertices.index(self)+1) % @game.grid.width != 0) && !@right
  end
  
  def can_have_left
    ((@game.grid.vertices.index(self)+1) % @game.grid.width != 1) && !@left
  end
  
  def can_have_down
    v = @game.grid.vertices
    index = v.index(self)
    row = (index/@game.grid.width).to_i
    last_row = (v.length/@game.grid.width-1).to_i
    (row != last_row) && !@down
  end
  
  def can_have_up
    @game.grid.vertices.index(self) > @game.grid.width-1 && !@up
  end
end