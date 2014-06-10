unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'Extensions\extensions'

class EggSplatPlugin
  include Purugin::Plugin, Purugin::Tasks
  include Purugin::Extensions

  description 'EggSplat', 0.5
  
    @@backlog = []
  def on_enable    
    sync_task(0, 0.1) { p = @@backlog.pop; p.each{|q| q.call() if q} if p }
     event(:projectile_hit) do |e|
		if e.entity.type.to_s == "EGG" 
            b = e.entity.location.block.block_at(:down)
			glaze(b, b.type,0) 
		end
    end
  end
  
  def glaze(block, m, d)
    puts "#{block.inspect} Material: #{m}"
    return if d > 10
    return if block.is?(:glass)
	if(block.is?(m) && !block.is?(:air))
        @@backlog[d] ||= []
        puts "Glaze it!"
		block.type = :glass.to_material
		@@backlog[d] << ->(){glaze(block.block_at(:down ),m,d+1)}
		@@backlog[d] << ->(){glaze(block.block_at(:north),m,d+1)}
		@@backlog[d] << ->(){glaze(block.block_at(:south),m,d+1)}
		@@backlog[d] << ->(){glaze(block.block_at(:east ),m,d+1)}
		@@backlog[d] << ->(){glaze(block.block_at(:west ),m,d+1)}
		@@backlog[d] << ->(){glaze(block.block_at(:up ),m,d+1)}
	end
  end
  
end