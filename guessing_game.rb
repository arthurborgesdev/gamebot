class GuessingGame
  attr_reader :guessed_word

  def initialize
    @words = ["duck", "building", "plane", "girl", "refrigerator", "chair", "television", "bed"]
    @word = random_word
    @guessed_word = @word.map { |letter| " _ " }
  end

  def start(bot, message)
    bot.api.send_message(chat_id: message.chat.id, 
      text: "Hello, #{message.from.first_name}, please guess a word with #{@word.size} letters\n#{guessed_word}"
    )
  end

  def random_word
    @words[rand(@words.size)].split("")
  end

  def guess(bot, message)
    msg = message.text.downcase

    bot.api.send_message(chat_id: message.chat.id, 
      text: "Please guess a word sending ONE letter a time") if msg.count("a-zA-Z") != 1
    
    if @word.include?(msg)
      index = @word.index(msg)
      guessed_word = guessed_word.map.with_index { |letter, idx| index == idx ? msg : letter }

      bot.api.send_message(chat_id: message.chat.id, 
      text: "You guessed right! \n#{guessed_word}"
    )
    else
      bot.api.send_message(chat_id: message.chat.id, 
        text: "You guessed wrong! Try again!") 
    end
  end
end