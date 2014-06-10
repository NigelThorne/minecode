unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'Extensions\extensions'

class StairCasePlugin
  include Purugin::Plugin
  include Purugin::Items
  include Purugin::Extensions

  description 'StairCase', 0.1
  
  
  def on_enable    
    event(:block_break) do |e|
        depth = 25
		if e.player.item_in_hand.type.is?(:seeds) && e.block.is?(:leaves)
            face = (e.block.get_face(e.player.location.block) || e.block.get_face(e.player.location.block.block_at(:up))).opposite_face
            right_face = e.block.rotate(face,:left)
            left_face = e.block.rotate(face,:right)
			tunnel(e.block, face, depth)
			tunnel(e.block.block_at(right_face), face, depth)
			tunnel(e.block.block_at(left_face), face, depth)
			stairs(e.block, face, depth)
			stairs(e.block.block_at(right_face), face, depth)
			stairs(e.block.block_at(left_face), face, depth)
			torch(e.block.block_at(left_face), face, left_face.opposite_face, depth)
		end
    end  

#    event(:block_damage) do |e|
#		if e.player.item_in_hand.type.is?(:seeds) #&& e.block.is?(:stone)
#        #    e.block.setTypeIdAndData(e.block.material.id, e.block.data +1, false)
#           face = (e.block.get_face(e.player.location.block) || e.block.get_face(e.player.location.block.block_at(:up))).opposite_face
#           changeTorch(e.block, :torch.to_material, face);
# 		end       
#    end
  end
  
  def safe_break(block, drop)
    return if block.is?(:bedrock)
    block.break!(true)
  end

    
  def tunnel(block, face, depth)
	return if depth <= 0
			
		safe_break(block, true)
		safe_break(block.block_at(:up), true)
		safe_break(block.block_at(:up).block_at(:up), true)
		safe_break(block.block_at(:down), true)
		first_step = block.block_at(:down).block_at(:down)
        first_step.break!(true)
		
        tunnel(block.block_at(:down).block_at(face), face, depth -1)
  end

  def stairs(block, face, depth)
	return if depth <= 0
		first_step = block.block_at(:down).block_at(:down)
    
        changeToStairs(first_step, :dark_oak_stairs.to_material, face.opposite_face)
		
        stairs(block.block_at(:down).block_at(face), face, depth -1)
  end

  def torch(block, face, edge_face, depth)
	return if depth <= 0
    
        changeToTorch(block, edge_face.opposite_face)
		
        torch(block.block_at(:down).block_at(face), face, edge_face, depth -1)
  end
end