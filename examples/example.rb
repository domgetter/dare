require 'dare'

class Paddle

  attr_reader :x, :y, :width, :height

  def initialize(window, side)
    @window = window
    @side = side
    @x = 20
    @y = Game::HEIGHT/2
    @width = 30
    @height = 80
  end

  def draw
    @window.draw_rect(
      top_left: [@x,@y-@height/2],
      width: @width,
      height: @height,
      color: 'red'
    )
  end

  def update
    @y = @window.mouse_y
    if @y < @height/2
      @y = @height/2
    end
    if @y > Game::HEIGHT - @height/2
      @y = Game::HEIGHT - @height/2
    end
  end

end

class Ball

  def initialize(window)
    reset!
    @size = 10
    @window = window
  end

  def draw
    @window.draw_rect(
      top_left: [@x-@size,@y-@size],
      width: 2*@size,
      height: 2*@size,
      color: 'red'
    )
  end

  def update
    if (@x > Game::WIDTH) || (@x < 0)
      reset!
    end
    if (@y > Game::HEIGHT-@size) || (@y < 0+@size)
      @angle = 360-@angle
    end
    if collided_with(@window.paddles[0])
      @angle = (180-@angle)%360
    end
    @x += Dare.offset_x(@angle, @speed)
    @y += Dare.offset_y(@angle, @speed)
  end

  def collided_with(paddle)
    hmm = ((@x-@size) < (paddle.x+paddle.width)) && ((@y < paddle.y+paddle.height/2) && (@y > paddle.y-paddle.height/2))
    #{}`console.log(#{hmm})`
    hmm
  end

  def reset!
    @x = Game::WIDTH/2
    @y = Game::HEIGHT/2
    @angle = 45*rand
    @angle = -1*@angle if rand > 0.5
    @angle = @angle+180 if rand > 0.5
    @speed = 8
  end

end

class Game < Dare::Window

  WIDTH = 1024
  HEIGHT = 768

  attr_reader :paddles

  def initialize
    super width: WIDTH, height: HEIGHT
    @ball = Ball.new(self)
    @paddles = []
    @paddles[0] = Paddle.new(self, :left)
    #@paddle2 = Paddle.new(:right)
  end

  def draw
    @ball.draw
    @paddles[0].draw
  end

  def update
    @ball.update
    @paddles[0].update
  end

end

Game.new.run!