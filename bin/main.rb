require 'dotenv/load'
require 'json'
require 'telegram/bot'

require_relative '../lib/guessing_game'
require_relative '../lib/session'

session = Session.new

Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      if session.start?(message.chat.id)
        bot.api.send_message(chat_id: message.chat.id,
                             text: 'You already started the game. Guess a letter or /stop')
      else
        session.add(message.chat.id, GuessingGame.new)
        current_session = session.retrieve(message.chat.id)
        current_session.start(bot, message)
      end
    when 'a'..'z', 'A'..'Z'
      if session.start?(message.chat.id)
        current_session = session.retrieve(message.chat.id)
        current_session.guess(bot, message, session)
      end
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id,
                           text: "Bye, #{message.from.first_name},
                           start the game again typing /start")
    else
      bot.api.send_message(chat_id: message.chat.id,
                           text: "I do not recognize this command, please try again!
                            Or type /start to init the game!")
    end
  end
end
