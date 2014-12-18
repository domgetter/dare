require 'dare'

class Star
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @creation_time = Dare.ms
    @x = rand 640
    @y = rand 480
  end

  def draw
    img = @animation[((Dare.ms-@creation_time)/100).to_i % @animation.size]
    img.draw_rot(@x, @y)
  end

  def update
  end

end

class Player

  def initialize
    @image = Dare::Image.new('assets/Starfighter.png')
    @grab_star_beep = Dare::Sound.new('assets/Beep.wav', overlap: 10)
    @x = @y = @vel_x = @vel_y = 0.0
    @angle = 90.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle += 4.5
  end

  def turn_right
    @angle -= 4.5
  end

  def accelerate
    @vel_x += Dare.offset_x(@angle, 0.5)
    @vel_y += Dare.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, @angle)
  end

  def score
    @score
  end

  def collect_stars(stars)
    if stars.reject! {|star| Dare.distance(@x, @y, star.x, star.y) < 35 }
      @score += 1
      @grab_star_beep.play
    end
  end
end

class Game < Dare::Window

  def initialize
    super width: 640, height: 480, border: true
    self.caption = "Dare Tutorial Game"

    @background_image = Dare::Image.new('assets/Space.png')
    @player = Player.new
    @player.warp 320, 240

    @star_animation = Dare::Image.load_tiles('assets/Star.png', width: 25)
    @stars = []

    @font = Dare::Font.new(font: "Arial", size: 20, color: 'yellow')
  end

  def draw
    @background_image.draw
    @player.draw
    @stars.each(&:draw)
    @font.draw("Score: #{@player.score}", 20, 20)
  end

  def update
    if button_down? Dare::KbLeft
      @player.turn_left
    end
    if button_down? Dare::KbRight
      @player.turn_right
    end
    if button_down? Dare::KbUp
      @player.accelerate
    end
    @stars.each(&:update)
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25
      @stars << Star.new(@star_animation)
    end
  end

end

Game.new.run!