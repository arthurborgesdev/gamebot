require 'dotenv/load'
require 'json'
require 'telegram/bot'

require_relative './guessing_game'
require_relative './session'

game = GuessingGame.new

Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
  session.push([message.chat.id, 'start', 0]) if scan(session, message.chat.id).empty?
  bot.listen do |message|     
    case message.text
    when '/start'  
      game.start(bot, message, message.chat.id)
    when 'a'..'z'  
      puts message
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, 
        text: "Bye, #{message.from.first_name}, start the game again typing '/start'"
      )
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I do not recognize this command, please try again!")
    end  
  end
end

