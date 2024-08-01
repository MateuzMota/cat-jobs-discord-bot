# frozen_string_literal: true

class LinkedInScraper
  attr_reader :url, :doc

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML5.parse(URI.open(url), max_errors: 10)
    log_errors
  end

  def log_errors
    doc.errors.each do |err|
      puts err
    end
  end

  def fetch_jobs
    doc.css('ul.jobs-search__results-list > li').map do |job|
      {
        title: job.css('h3.base-search-card__title').text.strip || nil,
        link: job.css('a.base-card__full-link').attr('href') || nil,
        logo: job.css('div.search-entity-media img').attr('data-delayed-url') || nil,
        company: job.css('h4.base-search-card__subtitle a').text.strip || nil,
        company_link: job.css('h4.base-search-card__subtitle a').attr('href') || nil,
        location: job.css('span.job-search-card__location').text.strip || nil,
        posted_at: job.css('time.job-search-card__listdate--new').text.strip || nil
      }
    end
  end
end