class AlwaysNightPlugin
  include Purugin::Plugin, Purugin::Colors, Purugin::Tasks
  description 'A world that is always dark', 0.1
  
  def on_enable
    sync_task(0, 20) do
      server.worlds.each do |world|
        time = world.time
        relative_time = ((time - 14_000) % (20_000 - 14_000)) #hours of night 
        world.time = 14_000 + relative_time
      end
    end
  end
end