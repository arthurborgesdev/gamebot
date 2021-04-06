require 'dotenv/load'
require 'uri'
require 'net/http'

base_url = 'https://api.telegram.org/bot'

uri = URI("#{base_url}#{ENV['BOT_TOKEN']}/getMe")
res = Net::HTTP.get_response(uri)
puts res.body if res.is_a?(Net::HTTPSuccess)