# frozen_string_literal: true

class JsonFileHandler
  attr_accessor :jobs_file

  def initialize(file_path)
    @file_path = file_path
    @jobs_file = []
  end

  def read_file
    if File.exist?(@file_path) && !File.zero?(@file_path)
      file = File.read(@file_path)
      @jobs_file = JSON.parse(file, symbolize_names: true)
    end
  end

  def write_file(job)
    @jobs_file << job
    File.write(@file_path, JSON.pretty_generate(@jobs_file))
  end
end
