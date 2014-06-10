require 'java'
    java_import org.kitteh.tag.PlayerReceiveNameTagEvent
    java_import org.kitteh.tag.TagAPI


module Purugin
  module Event
    # FIXME: This only handles normal priority.  Real fix is to generate these on demand versus up
    # front.  We can reify what we need.  This will also fix custom event types.    

    require 'jruby/core_ext' 
    

#    class PlayerReceiveNameTagEventListener
#      include org.bukkit.event.Listener
#      def initialize(&code); @code = code; end
#      def on_event(event); @code.call(event); end
#      add_method_signature 'on_event', [java.lang.Void::TYPE, org.kitteh.tag.PlayerReceiveNameTagEvent]
#      add_method_annotation 'on_event', org.bukkit.event.EventHandler => {}
#      become_java!
#    end
#    EVENT_NAME_TO_LISTENER[:player_receive_name_tag] = PlayerReceiveNameTagEventListener

    define_event_listener('PlayerReceiveNameTagEvent', 'org.kitteh.tag')

  end
end


class PurpleOpPlugin
  include Purugin::Plugin, Purugin::Colors
  description( 'PurpleOp', 0.3 )
   required :TagAPI

  def player_color(player)
    return ChatColor::LIGHT_PURPLE if @owners.include? player.name      
    return ChatColor::RED if player.is_op?
    return ChatColor::DARK_AQUA if @moderator.include? player.name
    return ChatColor::GOLD if @donators.include? player.name
    ChatColor::WHITE
  end

  def on_enable
    @owners = (config.get!("purpleop.owners", "nigelthorne")).split(",")        
    @moderator = (config.get!("purpleop.moderator", "")).split(",")        
    @donators = (config.get!("purpleop.donators", "")).split(",")

    event(:async_player_chat) do |e|
      e.format = "< #{color(player_color(e.player),"%1$s")} > %2$s"
    end

#    event(:player_receive_name_tag) do |e,*args|
#      col = player_color(e.named_player)
#      name = e.named_player.name
#      e.set_tag(color(col,name));
#    end
  end
end