require_relative '../lib/guessing_game'

describe GuessingGame do

  describe '#intialize' do
    gg = GuessingGame.new 
    words = gg.instance_variable_get(:@words)
    word = gg.instance_variable_get(:@word)
    guessed_word = gg.instance_variable_get(:@guessed_word)
    word_joined = word.join
    it 'initializes an Array with at least one word' do 
      expect(words.size).to be >= 1
    end
    it 'selects a random word from the existing array' do
      expect(words).to include(word_joined)
    end
    it 'matches the number of dashes with the number of letters in the word' do
      expect(word.size).to be == guessed_word.size
    end
  end
end