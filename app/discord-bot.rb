# frozen_string_literal: true

class DiscordBot
  def initialize(token, webhook)
    @bot = Discordrb::Bot.new(token: token, intents: [:server_messages])
    @client = Discordrb::Webhooks::Client.new(url: webhook)

    register_commands
  end

  def register_commands
    @bot.register_application_command(:horas, 'Que horas são?')

    @bot.application_command(:horas) do |event|
      time = Time.now
      event.respond(content: time)
    end
  end

  def message_channel
    @client.execute do |builder|
      builder.content = 'Hello world!'
      builder.add_embed do |embed|
        embed.title = "title"
        embed.colour = 0x1e234
        embed.url = "https://discordapp.com"
        embed.description = "this supports [named links](https://discordapp.com) on top of the previously shown subset of markdown. ```\nyes, even code blocks```"
        embed.timestamp = Time.at(1722551144)
        embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://cdn.discordapp.com/embed/avatars/0.png")
      end
    end
  end

  def run
    @bot.run
  end
end
