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

  describe '#random_word' do
    gg = GuessingGame.new
    words = gg.instance_variable_get(:@words)
    it 'picks a random word from array of words' do
      expect(words).to include(gg.random_word.join)
    end
  end

  describe '#replace_letters' do
    gg = GuessingGame.new
    gg.instance_variable_set(:@word, %w[g i r l])
    gg.instance_variable_set(:@guessed_word, [' _ ', ' _ ', ' _ ', ' _ '])
    it 'puts letters in the underline array' do
      gg.replace_letters('g')
      new_guessed_word = gg.instance_variable_get(:@guessed_word)
      expect(new_guessed_word).to eql(['g', ' _ ', ' _ ', ' _ '])
    end
  end
end
