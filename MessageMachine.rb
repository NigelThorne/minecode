class MessageMachinePlugin
  include Purugin::Plugin, Purugin::Colors
  description 'Message Machine', 0.2
  
  def display_messages(me)
    messages = config.get("messagemachine."+ me.name)
    if(messages!=nil) 
      me.msg "Messages:"
      messages.each_line { |line| me.msg "    "+line }
      me.msg " "
      config.set! "messagemachine."+me.name, ""
    end
  end
  
  def make_message_from_cli(from, *args)
    colorize_string "#{from}: #{args.join(" ").split("#").join("\n")}"
  end

  def on_enable    
    event(:player_join) { |e| display_messages(e.player) }
    
    public_command('msg', 'Leave a Message for someone', '/msg player_name message') do |me, *args|
      if args.length > 0
        recipient, *args = *args
        new_message = make_message_from_cli(me.name, *args)
        him = server.get_player(recipient)
        if(him!=nil) 
          him.send_raw_message(new_message)
        else
          messages = (config.get("messagemachine."+ recipient) || "").split("\n")
          messages << new_message
          config.set! "messagemachine."+recipient, messages.join("\n")
        end
      else
        display_messages me
      end
    end
  end
end