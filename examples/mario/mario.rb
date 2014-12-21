require 'dare'
require 'json'

class Level

  attr_reader :background_color, :images

  def initialize(path, window = Dare.default_canvas)
    @data = JSON.parse("{\n  \"id\":\"level1\",\n  \"background_color\":\"#6f84ff\",\n  \"tiles\":{\n    \"bricks\":{\n      \"ground\":[[0,12,16,12],[0,13,14,13]],\n      \"question_mark\":[[8,16]]\n    },\n    \"background\":{\n      \"hill_5\":[[0,8]],\n      \"shrub_5\":[[11,10]],\n      \"hill_3\":[[16,9]]\n    }\n  }\n}")
    @background_color = @data["background_color"]
    @tiles = @data["tiles"]
    @window = window
    load_images
  end

  def load_images
    @images = {}
    @images[:block_ground] = Dare::Image.new('assets/block_ground.png')
    @images[:bg_hill_5] = Dare::Image.new('assets/bg_hill_5.png')
    @images[:bg_shrub_5] = Dare::Image.new('assets/bg_shrub_5.png')
  end
end

class Camera
  attr_accessor :x
  def initialize(window = Dare.default_canvas)
    @window = window
    @x = 0
  end

  def update
    if @window.button_down? Dare::KbRight
      @x += 2
    end
    if @window.button_down? Dare::KbLeft
      @x -= 2
    end
    if @x < 0
      @x = 0
    end
  end
end

class Game < Dare::Window

  WIDTH = 256
  HEIGHT = 224
  TILE_WIDTH = 16

  def initialize
    super width: WIDTH, height: HEIGHT, border: true
    Dare.default_canvas = self
    @level = Level.new('level1.json')
    @camera = Camera.new
    @font = Dare::Font.new("16px Arial")
    @mario = Dare::Sprite.new
    @mario.state[:stand_right] << Dare::Image.new("assets/mario_stand_right.png")
    @mario.state[:stop_right] << Dare::Image.new("assets/mario_stand_left.png")
    @mario.state[:stop_right].next = @mario.state[:walk_left]
    @mario.state[:walk_right] << Dare::Image.new("assets/mario_walk_right_1.png")
    @mario.state[:walk_right] << Dare::Image.new("assets/mario_walk_right_2.png")
    @mario.state[:walk_right] << Dare::Image.new("assets/mario_walk_right_3.png")
  end

  def draw
    draw_background
    draw_tiles
    @mario.draw(TILE_WIDTH*3, TILE_WIDTH*11)
  end

  def update
    @camera.update
    @mario.update
  end

  def draw_background
    draw_rect(top_left: [0,0], width: WIDTH, height: HEIGHT, color: @level.background_color)
  end

  def draw_tiles
    @level.images[:bg_hill_5].draw(TILE_WIDTH*0-@camera.x,TILE_WIDTH*9)
    @level.images[:bg_shrub_5].draw(TILE_WIDTH*11-@camera.x,TILE_WIDTH*11)
    (0..16).each do |x|
      @level.images[:block_ground].draw(TILE_WIDTH*x-@camera.x, TILE_WIDTH*12)
      @level.images[:block_ground].draw(TILE_WIDTH*x-@camera.x, TILE_WIDTH*13)
    end
  end

end

Game.new.run!
