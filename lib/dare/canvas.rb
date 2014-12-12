module Dare
  class Canvas
    attr_reader :id, :canvas
    def initialize(opts = {})
      opts[:width] ||= 640
      opts[:height] ||= 480
      opts[:border] ||= false
      `var my_canvas = document.createElement("canvas")`
      @id = rand(36**8).to_s(36)
      `my_canvas.setAttribute('id', #{@id})`
      `my_canvas.width = #{opts[:width]}`
      `my_canvas.height = #{opts[:height]}`
      `my_canvas.style.border = "solid 1px black"` if opts[:border]
      `document.body.appendChild(my_canvas)`
      @canvas = `my_canvas`
    end
    def context
      `#{@canvas}.getContext('2d')`
    end
  end
end