class CartsCanKillPlugin
	include Purugin::Plugin
	description 'CartsCanKillPlugin', 0.2

	def on_enable    
		event(:vehicle_entity_collision) do |e|
			if(e.entity.monster?) 
				e.entity.damage(e.entity.health)
				e.cancelled = true
				#nice to give the minecart a kick to keep it rolling at this point...
				e.vehicle.velocity = e.vehicle.location.direction 
			end
		end
	end
end
