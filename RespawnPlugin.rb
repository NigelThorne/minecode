# Teleports you to a known location if you fall out of the world.
# used in my world to drop you over the spawn, so you stuff drops there when you die.

class RespawnPlugin
	include Purugin::Plugin
	description 'RespawnPlugin', 0.2

	def on_enable    
		event(:player_move) do |e|      
			me = e.player
	    	if(me.location.y < 0 ) #fallen too far
	    		me.teleport(me.location.tap { |loc|
	    			loc.x = -29
	    			loc.y = 261
	    			loc.z = 247
	    		})
	    	end
		end
	end
end

