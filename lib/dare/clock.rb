module Dare
  class Clock

    def initialize(opts = {})
      opts[:update_interval] ||= 16.666
      @update_interval = opts[:update_interval]
    end

    def start(&block)
      @interval = `setInterval(function(){#{block.call}}, #{@update_interval})`
    end

    def stop
      `clearInterval(#@interval)`
    end
  end
end