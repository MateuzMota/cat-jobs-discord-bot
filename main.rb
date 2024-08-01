# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'
require 'nokogiri'
require 'open-uri'

URL = ENV['LINKEDIN_URL_WITH_PARAMS'] || nil
TOKEN = ENV['SLASH_COMMAND_BOT_TOKEN'] || nil

doc = Nokogiri::HTML5.parse(URI.open(URL), max_errors: 10)
doc.errors.each do |err|
  puts(err)
end

jobs = doc.css('ul.jobs-search__results-list > li')

jobs.each do |job|
  link_element = job.css('a.base-card__full-link')
  title_element = job.css('h3.base-search-card__title')
  logo_element = job.css('div.search-entity-media img')
  company_element = job.css('h4.base-search-card__subtitle a')
  location_element = job.css('span.job-search-card__location')
  posted_at_element = job.css('time.job-search-card__listdate--new')

  title = title_element.text.strip || 'error'
  link = link_element.attr('href').value || 'error'
  logo = logo_element.attr('data-delayed-url').value || 'error'
  company = company_element.text.strip || 'error'
  company_link = company_element.attr('href').value || 'error'
  location = location_element.text.strip || 'error'
  posted_at = posted_at_element.text.strip || 'error'

  puts "Título: #{title}"
  puts "Link: #{link}"
  puts "Logo: #{logo}"
  puts "Empresa: #{company}"
  puts "LinkedIN da Empresa: #{company_link}"
  puts "Localização: #{location}"
  puts "Data: #{posted_at}"
end

bot = Discordrb::Bot.new(token: TOKEN, intents: [:server_messages])

bot.register_application_command(:horas, 'Que horas são?')

bot.application_command(:horas) do |event|
  time = Time.now

  event.respond(content: time)
end

bot.run
