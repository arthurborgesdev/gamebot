class GuessingGame
  def initialize
    @words = ["duck", "building", "plane", "girl", "refrigerator", "chair", "television", "bed"]
  end

  def start(bot, message, id)
    @word = random_word
    bot.api.send_message(chat_id: message.chat.id, 
      text: "Hello, #{message.from.first_name}, please guess a word with #{@word.size} letters"
    )
  end

  def random_word
    @words[rand(@words.size)]
  end
end