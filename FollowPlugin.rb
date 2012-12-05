class FollowPlugin
  include Purugin::Plugin, Purugin::Tasks
  description( 'Follow', 0.1 )

  @@follows = {}

  def unfollow(me)
    if(@@follows[me.name])
      server.scheduler.cancel_task(@@follows[me.name])
      @@follows.delete(me.name)
    end
  end

  def on_enable
    public_command('follow', 'Trail someone', '/follow player_name') do |me, *args|
      if me.permission? "follow.follow"
        if args.length == 1
          unfollow(me)
          server.dispatch_command(me, 'invisible')
          server.dispatch_command(me, 'gamemode 1')
          me.setFlying(true)
          me.msg "Now following #{args[0]}"      
          @@follows[me.name] = async_task(0, 3) { 
              him = server.get_player(args[0])
              if(him!=nil) 
                me.teleport(him.location.subtract(him.location.direction.multiply(3)), org.bukkit.event.player.PlayerTeleportEvent::TeleportCause::PLUGIN)
              end
          }
        end
      else
        me.msg "You do not have permission"
      end
    end

    public_command('unfollow', 'Stop trailing someone', '/unfollow') do |me, *args|      
      if me.permission? "follow.follow"
        unfollow(me)
        me.msg "No longer following anyone"
      else
        me.msg "You do not have permission"
      end
    end
  end

end
