module Dare
  class Sprite
    attr_accessor :images, :state
    def initialize(window = Dare.default_canvas)
      @window = window
      @images = []
      @state = Hash.new {|h,k| h[k] = Dare::AnimationState.new}
      @current_image = 0
      @ticks_on_current_image = 0
      @x = 0
      @y = 0
    end

    def draw(x = 0, y = 0)
      @images[@current_image].draw(x, y)
    end

    def update
      if @window.button_down? Dare::KbRight
        walk
      else
        stand
      end
    end

    def walk
      if @current_image == 0
        @current_image = 2
        @ticks_on_current_image = 0
      elsif @current_image == 2
        if @ticks_on_current_image >= 5
          @current_image = 3
          @ticks_on_current_image = 0
        else
          @ticks_on_current_image += 1
        end
      elsif @current_image == 3
        if @ticks_on_current_image >= 5
          @current_image = 4
          @ticks_on_current_image = 0
        else
          @ticks_on_current_image += 1
        end
      elsif @current_image == 4
        if @ticks_on_current_image >= 5
          @current_image = 2
          @ticks_on_current_image = 0
        else
          @ticks_on_current_image += 1
        end
      end
    end

    def stand
      @current_image = 0
      @ticks_on_current_image = 0
    end
  end
end