require 'java'

class AutoSavePlugin
  include Purugin::Plugin, Purugin::Tasks
  description( 'AutoSave', 0.1 )

  def on_enable
    con = server.get_console_sender
    con.msg "AutoSave Starting"

    path = server.world_container.name
    async_task(600, 600) { 
      console = server.get_console_sender
      server.dispatch_command(console, 'save-all')
      sleep(2.0)
      console.msg `git add ./world*`
      console.msg `git commit -m "world update"`
    } 
  end

end
