
class Enemy
  attr_reader :x, :y, :life

  def initialize(game)
    @game = game
    @origin = @game.grid.vertices[1..-1].sample
    @location = @origin
    @x, @y = @location.x, @location.y
    @at_vertex = true
    @max_life = 25
    @life = @max_life
    @speed = 1.2 + rand/2.5
  end
  
  def update
    #if at vertex, choose some neighbor vertex to be new destination
    # if on edge, continue on your way to destination
    if @at_vertex
      @life -= 1
      @r = 255.0*@life/@max_life
      @g = 10.0*@life/@max_life
      #`console.log(#{"rgb(#{@r},#{@g},0)"})`
      @destination = @location.neighbors.sample
      @at_vertex = false
      @distance_until_destination_x = @destination.x - @location.x
      @distance_until_destination_y = @destination.y - @location.y
    end
    
    if @life <= 0
      die
    end
    
    if near_another_enemy && alive
      @life = @max_life
      @r = 255.0
      @g = 10.0
    end
    
    @x += d_x
    @y += d_y
    
    return !alive
  end
  
  def d_x
    change_in_x = 0
    if @distance_until_destination_x > 0
      change_in_x = @speed
      @distance_until_destination_x -= @speed
      if @distance_until_destination_x <= 0
        change_in_x = 0
        @location = @destination
        @x = @location.x
        @y = @location.y
        @at_vertex = true
        @distance_until_destination_x = 0
      end
    elsif @distance_until_destination_x < 0
      change_in_x = -@speed
      @distance_until_destination_x += @speed
      if @distance_until_destination_x >= 0
        change_in_x = 0
        @location = @destination
        @x = @location.x
        @y = @location.y
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
        change_in_y = 0
        @location = @destination
        @x = @location.x
        @y = @location.y
        @at_vertex = true
        @distance_until_destination_y = 0
      end
    elsif @distance_until_destination_y < 0
      change_in_y = -@speed
      @distance_until_destination_y += @speed
      if @distance_until_destination_y >= 0
        change_in_y = 0
        @location = @destination
        @x = @location.x
        @y = @location.y
        @at_vertex = true
        @distance_until_destination_y = 0
      end
    end
    change_in_y
  end
  
  def near_another_enemy
  
    @game.enemies.reject {|e| e == self}.any? {|e| Dare.distance(e.x, e.y, @x, @y) <= 25}
  end
  
  def die
    @alive = false
  end
  
  def alive
    @life > 0
  end
  
  def draw
    # draw circle at current x, y
    @game.draw_circle(center:[@x,@y], radius: 8, color: "rgb(#{@r.to_i},#{@g.to_i},0)")
  end
end