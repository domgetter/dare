require 'dare'

class Paddle

  attr_reader :x, :y, :width, :height

  def initialize(game, side)
    @game = game
    @side = side
    @x = 20
    @y = Game::HEIGHT/2
    @width = 30
    @height = 80
  end

  def draw
    @game.draw_rect(
      top_left: [@x,@y-@height/2],
      width: @width,
      height: @height,
      color: 'red'
    )
  end

  def update
    @y = @game.mouse_y || Game::HEIGHT/2
    if @y < @height/2
      @y = @height/2
    end
    if @y > Game::HEIGHT - @height/2
      @y = Game::HEIGHT - @height/2
    end
  end

end

class Ball

  def initialize(game)
    reset!
    @size = 10
    @game = game
  end

  def draw
    @game.draw_rect(
      top_left: [@x-@size,@y-@size],
      width: 2*@size,
      height: 2*@size,
      color: 'red'
    )
  end

  def update
    check_bounds
    if overlapped_with(@game.paddles[0])
      @angle = (180.0-@angle)
      @game.boops[:paddle].play
    end
    @x += Dare.offset_x(@angle, @speed)
    @y += Dare.offset_y(@angle, @speed)
  end

  def check_bounds
    if (@x > Game::WIDTH)
      @game.score += 1
      reset!
    end
    if (@x < 0)
      reset!
    end
    if (@y > Game::HEIGHT-@size) || (@y < 0+@size)
      @angle = 360.0-@angle
      @game.boops[:wall].play
    end
  end

  def overlapped_with(paddle)
    left_side_of_ball_past_right_side_of_paddle(paddle) &&
    right_side_of_ball_past_left_side_of_paddle(paddle) &&
    top_of_ball_past_bottom_of_paddle(paddle) &&
    bottom_of_ball_past_top_of_paddle(paddle)
  end

  def left_side_of_ball_past_right_side_of_paddle(paddle)
    (@x-@size) < (paddle.x+paddle.width)
  end

  def right_side_of_ball_past_left_side_of_paddle(paddle)
    (@x+@size) > (paddle.x-paddle.width)
  end

  def top_of_ball_past_bottom_of_paddle(paddle)
    (@y+@size) < paddle.y+paddle.height/2
  end

  def bottom_of_ball_past_top_of_paddle(paddle)
    (@y-@size) > paddle.y-paddle.height/2
  end

  def reset!
    @x = Game::WIDTH/2.0
    @y = Game::HEIGHT/2.0+5
    @angle = 90.0*rand - 45.0
    @angle = @angle+180.0 if rand > 0.5
    @speed = 6.0
  end

end

class Game < Dare::Window

  WIDTH = 1024
  HEIGHT = 768

  attr_reader :paddles, :boops
  attr_accessor :score

  def initialize
    super width: WIDTH, height: HEIGHT, border: true
    @ball = Ball.new(self)
    @paddles = []
    @paddles[0] = Paddle.new(self, :left)
    @paddles[1] = Paddle.new(self, :right)
    @boops = {}
    @boops[:paddle] = Dare::Sound.new('assets/pong_bounce.mp3', 0.3)
    @boops[:wall] = Dare::Sound.new('assets/wall_bounce.mp3', 0.3)
    @score_font = Dare::Font.new(self)
    @score = 10
  end

  def draw
    @ball.draw
    @paddles[0].draw
    @score_font.draw(@score)
    #@paddles[1].draw
  end

  def update
    @ball.update
    @paddles[0].update
    #@paddles[1].update
  end

end

Game.new.run!