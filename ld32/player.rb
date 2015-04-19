class Player
  attr_reader :alive

  def initialize(game)
    @game = game
    @size = 20
    @speed = 4
    @x = 0
    @y = 0
    @moving = false
    @distance_until_destination_x = 0
    @distance_until_destination_y = 0
    @edges_to_place = 0
    @alive = true
    
    @at_vertex = true
    @location = @game.grid.vertices[0]
    @distination = nil
  end

  def draw
    x_offset = @game.grid.vertices[0].x
    y_offset = @game.grid.vertices[0].y
    @game.draw_circle(center:[@x+x_offset,@y+y_offset], radius:20, color: 'rgb(140,148,202)')
  end
  
  def update
    check_user_input
    place_edge

    @x += d_x
    @y += d_y
    if check_if_dead
      @alive = false
    end
    
    pick_up_edge
  end
  
  def check_if_dead
    x_offset = @game.grid.vertices[0].x
    y_offset = @game.grid.vertices[0].y
    @game.enemies.any? {|e| Dare.distance(@x+x_offset, @y+y_offset, e.x, e.y) <= 3}
  end
  
  def place_edge
    # can place an edge if im at a vertex
    # the direction I try to go is edgeless
    # the direction I try to go has a vertex
    # (opt) I have edges to place
  end
  
  def pick_up_edge
    if @grabbing && @at_vertex
      @grabbing = false
      if @previous.neighbors.length > 1 && @location.neighbors.length > 1
        @edges_to_place += 1
        case @previous_direction
        when :right
          @previous.right = false
          @location.left = false
        when :left
          @previous.left = false
          @location.right = false
        when :down
          @previous.down = false
          @location.up = false
        when :up
          @previous.up = false
          @location.down = false
        end
      end
    end
  end
  
  def d_x
    change_in_x = 0
    if @distance_until_destination_x > 0
      change_in_x = @speed
      @distance_until_destination_x -= @speed
      if @distance_until_destination_x <= 0
        @previous = @location
        @previous_direction = :right
        @location = @destination
        @at_vertex = true
        @distance_until_destination_x = 0
      end
    end
    if @distance_until_destination_x < 0
      change_in_x = -@speed
      @distance_until_destination_x += @speed
      if @distance_until_destination_x >= 0
        @previous = @location
        @previous_direction = :left
        @location = @destination
        @at_vertex = true
        @distance_until_destination_x = 0
      end
    end
    change_in_x
  end
  
  def d_y
    change_in_y = 0
    if @distance_until_destination_y > 0
      change_in_y = @speed
      @distance_until_destination_y -= @speed
      if @distance_until_destination_y <= 0
        @previous = @location
        @previous_direction = :down
        @location = @destination
        @at_vertex = true
        @distance_until_destination_y = 0
      end
    end
    if @distance_until_destination_y < 0
      change_in_y = -@speed
      @distance_until_destination_y += @speed
      if @distance_until_destination_y >= 0
        @previous = @location
        @previous_direction = :up
        @location = @destination
        @at_vertex = true
        @distance_until_destination_y = 0
      end
    end
    change_in_y
  end
  
  def check_user_input
    #if a button is pressed, go in that direction if there is an edge to travel on
    if @game.button_down? Dare::KbRight
      move_right
    end
    if @game.button_down? Dare::KbLeft
      move_left
    end
    if @game.button_down? Dare::KbDown
      move_down
    end
    if @game.button_down? Dare::KbUp
      move_up
    end
    if @game.button_down? Dare::KbSpace
      @grabbing = true unless @at_vertex
    end
    if @game.button_down? Dare::KbF
      @placing = true if @at_vertex
    end
  end
  
  def move_right
    #if we're at a vertex, start moving to the vertex to the right if there is a connecting edge
    if @at_vertex && @location.right
      @at_vertex = false
      @moving = true
      @placing = false
      @destination = @game.grid.vertex_to_right_of(@location)
      @distance_until_destination_x = @game.grid.cell_draw_size
    elsif @at_vertex && @placing && @location.can_have_right
      @placing = false
      if @edges_to_place >= 1
        @edges_to_place -= 1
        @at_vertex = false
        @moving = true
        @location.right = true
        @destination = @game.grid.vertex_to_right_of(@location)
        @distance_until_destination_x = @game.grid.cell_draw_size
        @destination.left = true
      end
    end
  end
  
  def move_left
    if @at_vertex && @location.left
      @at_vertex = false
      @moving = true
      @placing = false
      @destination = @game.grid.vertex_to_left_of(@location)
      @distance_until_destination_x = -@game.grid.cell_draw_size
    elsif @at_vertex && @placing && @location.can_have_left
      @placing = false
      if @edges_to_place >= 1
        @edges_to_place -= 1
        @at_vertex = false
        @moving = true
        @location.left = true
        @destination = @game.grid.vertex_to_left_of(@location)
        @distance_until_destination_x = -@game.grid.cell_draw_size
        @destination.right = true
      end
    end
  end
  
  def move_down
    if @at_vertex && @location.down
      @at_vertex = false
      @moving = true
      @placing = false
      @destination = @game.grid.vertex_below(@location)
      @distance_until_destination_y = @game.grid.cell_draw_size
    elsif @at_vertex && @placing && @location.can_have_down
      @placing = false
      if @edges_to_place >= 1
        @edges_to_place -= 1
        @at_vertex = false
        @moving = true
        @location.down = true
        @destination = @game.grid.vertex_below(@location)
        @distance_until_destination_y = @game.grid.cell_draw_size
        @destination.up = true
      end
    end
  end
  
  def move_up
    if @at_vertex && @location.up
      @at_vertex = false
      @moving = true
      @placing = false
      @destination = @game.grid.vertex_above(@location)
      @distance_until_destination_y = -@game.grid.cell_draw_size
    elsif @at_vertex && @placing && @location.can_have_up
      @placing = false
      if @edges_to_place >= 1
        @edges_to_place -= 1
        @at_vertex = false
        @moving = true
        @location.up = true
        @destination = @game.grid.vertex_above(@location)
        @distance_until_destination_y = -@game.grid.cell_draw_size
        @destination.down = true
      end
    end
  end

end
