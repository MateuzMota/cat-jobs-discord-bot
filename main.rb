# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'
require 'nokogiri'
require 'open-uri'

require_relative 'app/linkedin-scraper'
require_relative 'app/discord-bot'

URL = ENV['LINKEDIN_URL_WITH_PARAMS']
TOKEN = ENV['SLASH_COMMAND_BOT_TOKEN']

if URL && TOKEN
  scraper = LinkedInScraper.new(URL)
  jobs = scraper.fetch_jobs

  jobs.each do |job|
    puts "Título: #{job[:title]}"
    puts "Link: #{job[:link]}"
    puts "Logo: #{job[:logo]}"
    puts "Empresa: #{job[:company]}"
    puts "LinkedIN da Empresa: #{job[:company_link]}"
    puts "Localização: #{job[:location]}"
    puts "Data: #{job[:posted_at]}"
  end

  bot = DiscordBot.new(TOKEN)
  bot.run
end

puts 'URL ou TOKEN não definido.'
