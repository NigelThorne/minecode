class BouncerPlugin
  include Purugin::Plugin
  description 'Bouncer', 0.3
    
  def on_enable
    bouncy_material = config.get!('material', 'stone')
    
    # event(:entity_damage) do |e| # Done falling: don't take damage      
    #   me = e.entity
    #   if(me.name=="nigelthorne")
    #     if me.player?
    #       block = me.world.block_at(me.location).block_at(:down)
    #       if block.is? bouncy_material 
    #         e.cancelled = true
    #       end
    #     end
    #   end
    # end
    
    # event(:player_move) do |e|      
    #   me = e.player
    #   if(me.name=="nigelthorne")
    #     block = me.world.block_at(e.to).block_at(:down)
    #     if block.is?(bouncy_material) && me.fall_distance > 1.0 && me.velocity.y < 0
    #     me.msg("vel = #{me.velocity.y} fd = #{me.fall_distance}")
    #       me.velocity = me.velocity.tap do |dir|
    #         dir.y = me.fall_distance/10.0 
    #         if(me.sneaking?)
    #           dir.y = dir.y/2.0
    #         end
    #       end
    #       me.fall_distance = 0
    #     end
    #   end
    end
  end
end

