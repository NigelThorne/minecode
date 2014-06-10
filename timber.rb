unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'Extensions\extensions'

class TimberPlugin
  include Purugin::Plugin
  include Purugin::Extensions

  description 'Timber', 0.4
  
  
  def on_enable    
    event(:block_break) do |e|
		if e.block.is?(:log) && is_axe?(e.player.item_in_hand.type)
			fell(e.block)
		end
    end
    
  end
  
  def fell(block)
	if(block.is?(:log))
		block.break!(true)
		fell(block.block_at(:up))
		fell(block.block_at(:north))
		fell(block.block_at(:south))
		fell(block.block_at(:east))
		fell(block.block_at(:west))
	end
  end
end