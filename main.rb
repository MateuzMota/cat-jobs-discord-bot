# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

TOKEN = ENV['SLASH_COMMAND_BOT_TOKEN'] || nil

bot = Discordrb::Bot.new(token: TOKEN, intents: [:server_messages])

bot.register_application_command(:horas, 'Que horas são?')

bot.application_command(:horas) do |event|
  time = Time.now

  event.respond(content: time)
end

bot.run
