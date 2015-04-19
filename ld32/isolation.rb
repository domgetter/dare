require 'dare'
require_relative 'grid'
require_relative 'vertex'
require_relative 'enemy'
require_relative 'player'

class Level

  attr_reader :grid, :enemies, :player

  def initialize(window, level = {})
    @game = window
    @grid = Grid.new(
      self,
      width: level[:grid][:width],
      height: level[:grid][:height],
      cell_draw_size: level[:grid][:cell_draw_size])
    @enemies = []
    @player = Player.new(self)
    level[:enemies].times {@enemies << Enemy.new(self)}
  end
  
  def draw_line(opts)
    @game.draw_line(opts)
  end
  
  def button_down?(id)
    @game.button_down? id
  end
  
  def draw_circle(opts)
    @game.draw_circle(opts)
  end
  
end

class Isolation < Dare::Window

  def initialize
    super width: 640, height: 480, border: true
    @level_init = {grid:{width: 4, height: 4, cell_draw_size: 100}, enemies: 4}
    new_level(@level_init)
    @font = Dare::Font.new(font: "Arial", size: 72, color: '#333')
    @menu_font = Dare::Font.new(font: "Arial", size: 72, color: '#333')
    @submenu_font = Dare::Font.new(font: "Arial", size: 42, color: '#333')
    @legend_font = Dare::Font.new(font: "Arial", size: 20, color: '#555')
    @view = :menu
  end
  
  def new_level(level)
    @level = Level.new(self, level)
    @grid = grid
    @enemies = enemies
    @player = player
  end
  
  def grid
    @level.grid
  end
  
  def enemies
    @level.enemies
  end
  
  def player
    @level.player
  end

  def draw
    case @view
    when :menu
      draw_menu
    when :level
      draw_level
    end
  end
  
  def draw_menu
    @menu_font.draw("Isolation", 175, 100)
    @submenu_font.draw("Press Enter to start", 135, 210)
  end
  
  def draw_level
    @grid.draw
    @player.draw if @player.alive
    @enemies.each &:draw
    @legend_font.draw("R: Restart", 420, 150)
    @legend_font.draw("Space: Pick up edge", 420, 170)
    @legend_font.draw("F: Place Edge", 420, 190)
    @legend_font.draw("Esc: Menu", 420, 210)
    @legend_font.draw("Arrow Keys: Move", 420, 230)
    @legend_font.draw("Enemies die over time", 420, 270)
    @legend_font.draw("unless they touch", 420, 290)
    @legend_font.draw("their friends. You must", 420, 310)
    @legend_font.draw("isolate them.", 420, 330)
    if !@player.alive
      @font.draw("GAME OVER", 10, 10)
    end
    if @enemies.empty? && @player.alive
      @font.draw("YOU WIN", 100, 10)
    end
  end

  def update
    case @view
    when :menu
      menu_update
    when :level
      level_update
    end
  end
  
  def menu_update
    if button_down? Dare::KbEnter
      @view = :level
      new_level(@level_init)
    end
  end
  
  def level_update
    if button_down? Dare::KbEscape
      @view = :menu
    elsif button_down? Dare::KbR
      new_level(@level_init)
    else
      @enemies.delete_if {|enemy| enemy.update}
      @player.update if @player.alive
    end
  end

end

Isolation.new.run!