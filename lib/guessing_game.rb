class GuessingGame
  attr_reader :guessed_word

  def initialize
    @words = %w[duck building plane girl refrigerator chair television bed]
    @word = random_word
    @guessed_word = @word.map { ' _ ' }
  end

  def start(bot, message)
    bot.api.send_message(chat_id: message.chat.id,
                         text: "Hello, #{message.from.first_name}, please guess a word with
                                       #{@word.size} letters\n
                                       #{guessed_word}")
  end

  def random_word
    @words[rand(@words.size)].split('')
  end

  def guess(bot, message, session)
    msg = message.text.downcase

    if guessed_word.include?(msg)
      bot.api.send_message(chat_id: message.chat.id,
                           text: "Letter already sent, send another one!\n#{guessed_word}")
    elsif @word.include?(msg)

      replace_letters(msg)
      bot.api.send_message(chat_id: message.chat.id,
                           text: "You guessed right! \n#{guessed_word}")

      won?(bot, message, session)
    else
      bot.api.send_message(chat_id: message.chat.id,
                           text: "You guessed wrong! Try again!\n#{guessed_word}")
    end
  end

  def won?(bot, message, session)
    return unless guessed_word == @word

    session.flush(message.chat.id)

    bot.api.send_message(chat_id: message.chat.id,
                         text: "Congratulations!!! You guessed the whole word!!\n
                         Start the game again typing /start")
  end

  def replace_letters(msg)
    indices = []
    @word.each_with_index { |letter, idx| indices << idx if letter == msg }

    indices.each do |chosen_idx|
      guessed_word.map!.with_index do |letter, idx|
        chosen_idx == idx ? msg : letter
      end
    end
  end
end
