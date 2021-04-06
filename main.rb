require 'dotenv/load'
require 'json'
require 'telegram/bot'

require_relative './guessing_game'
require_relative './session'

session = Session.new

Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
  bot.listen do |message|     
    case message.text
    when '/start'  
      if session.start?(message.chat.id, 'start')
        bot.api.send_message(chat_id: message.chat.id, text: "You already started the game. Guess a letter or /stop")
      else
        session.add(message.chat.id, GuessingGame.new, 'start') 
        current_session = session.game_session(message.chat.id)
        current_session.start(bot, message)
      end
    when 'a'..'z', 'A'..'Z'
      if session.start?(message.chat.id, 'start')
        current_session = session.game_session(message.chat.id)
        current_session.guess(bot, message)
      end
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, 
        text: "Bye, #{message.from.first_name}, start the game again typing /start"
      )
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I do not recognize this command, please try again!")
    end  
  end
end
