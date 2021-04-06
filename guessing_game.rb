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

  def guess(bot, message, session)
    msg = message.text.downcase

    bot.api.send_message(chat_id: message.chat.id, 
      text: "Please guess a word sending ONE letter a time") if msg.count("a-zA-Z") != 1
    
    if @word.include?(msg)
      indices = []
      @word.each_with_index { |letter, idx| indices << idx if letter == msg }
      
      indices.each do |chosen_idx|
        guessed_word.map!.with_index do |letter, idx|
          chosen_idx == idx ? msg : letter
        end  
      end

      bot.api.send_message(chat_id: message.chat.id, 
        text: "You guessed right! \n#{guessed_word}"
      )

      if guessed_word == @word
        session.flush(message.chat.id)

        bot.api.send_message(chat_id: message.chat.id, 
          text: "Congratulations!!! You guessed the whole word!!\nStart the game again typing /start"
        )
      end 
    else
      bot.api.send_message(chat_id: message.chat.id, 
        text: "You guessed wrong! Try again!") 
    end
  end
end