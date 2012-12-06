require 'java'

#Monkey patch Purugin to include the new event. Note: There is a simple way to do this now.
module Purugin
  module Event
    # FIXME: This only handles normal priority.  Real fix is to generate these on demand versus up
    # front.  We can reify what we need.  This will also fix custom event types.    

    require 'jruby/core_ext' 

    class ExplosionPrimeEventListener
      include org.bukkit.event.Listener
      def initialize(&code); @code = code; end
      def on_event(event); @code.call(event); end
      add_method_signature 'on_event', [java.lang.Void::TYPE, org.bukkit.event.entity.ExplosionPrimeEvent]
      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
      become_java!
    end
    EVENT_NAME_TO_LISTENER[:explosion_prime] = ExplosionPrimeEventListener

  end
end


class NoExplosionPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'No Explosion', 0.2
  
  def on_enable    
  	event(:explosion_prime) do |e,*args|      
  		e.cancelled = true
  	end
  end
end