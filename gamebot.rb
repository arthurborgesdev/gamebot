require 'dotenv/load'
require 'json'
require 'telegram/bot'

Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
  bot.listen do |message|     
    case message.text
    when '/start'
      GuessGame.new()
      
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end  
  end
end

class GuessGame
  def initialize()
    @words = ["duck", "building", "plane", "girl", "refrigerator", "chair", "television", "bed"]
  end

  def greeting
  end

  def flush
    
  end

  def random_word

end