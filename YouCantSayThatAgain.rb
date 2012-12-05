#--------- examples/player_joined_full_class.rb ----------
class PurpleOpPlugin
  include Purugin::Plugin, Purugin::Colors
  description 'PurpleOp', 0.1

  def on_enable
    # Tell everyone in players world that they have joined
    event(:async_player_chat) do |e|
      e.format = "< #{light_purple("%1$s")} > %2$s" if e.player.is_op?
    end
  end
end