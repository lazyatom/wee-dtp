require "rubygems"
require "bundler/setup"
require "sinatra"
require 'sinatra/base'

$LOAD_PATH.unshift "lib"
require "sudoku"
require "weather"
Weather.api_key = ENV["WUNDERGROUND_API_KEY"].strip
BACKEND_HOST = ENV["BACKEND_HOST"]

class WeeDTP < Sinatra::Base
  helpers do
    def backend_print_url(options)
      "http://#{BACKEND_HOST}/print/#{options[:printer_id]}"
    end

    def backend_preview_url
      "http://#{BACKEND_HOST}/preview"
    end

    def period_of_day
      case Time.now.hour
      when 8..11
        "morning"
      when 12..14
        "lunch"
      when 15..18
        "afternoon"
      else
        "evening"
      end
    end
  end

  get "/" do
    @sudoku_data = random_sudoku
    # @forecast = Weather.new.daily_report
    erb :index
  end

  get "/message" do
    erb :message
  end

  get "/:template" do
    erb params["template"].to_sym
  end
end