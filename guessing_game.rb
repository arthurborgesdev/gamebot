class GuessingGame
  def initialize
    @words = ["duck", "building", "plane", "girl", "refrigerator", "chair", "television", "bed"]
    @word = random_word
  end

  def greeting
    bot.api.send_message(chat_id: message.chat.id, 
      text: "Hello, #{message.from.first_name}, please guess a word with #{@word.size} letters"
    )
  end

  def flush
    
  end

  def random_word
    @words[rand(@words.size)]
  end
end