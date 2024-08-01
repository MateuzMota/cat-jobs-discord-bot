# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'
require 'nokogiri'
require 'open-uri'
require 'json'

require_relative 'app/linkedin-scraper'
require_relative 'app/discord-bot'
require_relative 'app/json-file-handler'

URL = ENV['LINKEDIN_URL_WITH_PARAMS']
TOKEN = ENV['SLASH_COMMAND_BOT_TOKEN']
WEBHOOK = ENV['DISCORD_CHANNEL_WEBHOOK']
@bot = DiscordBot.new(TOKEN, WEBHOOK)

def main
  if URL && TOKEN && WEBHOOK
    scraper = LinkedInScraper.new(URL)
    jobs = scraper.fetch_jobs
    file_path = 'files/jobs_file.json'
    json_file = JsonFileHandler.new(file_path)

    File.zero?(file_path) && json_file.write_file(jobs)

    json_file.read_file

    jobs.each do |job|
      existing_job = json_file.jobs_file[0].find { |job_from_json| job_from_json['link'] == job['link'] }

      if existing_job
        puts 'já existe'
      else
        puts "Novo job: #{job}"
        json_file.write_file(job)
        # @bot.message_channel
      end
    end
    @bot.message_channel

  else
    puts 'URL, TOKEN ou WEBHOOK não definido.'
  end
end

Thread.new { @bot.run }

loop do
  main
  sleep 10
end
