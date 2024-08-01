# frozen_string_literal: true

class DiscordBot
  def initialize(token)
    @bot = Discordrb::Bot.new(token: token, intents: [:server_messages])
    register_commands
  end

  def register_commands
    @bot.register_application_command(:horas, 'Que horas são?')

    @bot.application_command(:horas) do |event|
      time = Time.now
      event.respond(content: time)
    end
  end

  def run
    @bot.run
  end
end