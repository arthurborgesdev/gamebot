require_relative '../lib/session'

describe Session do
  let(:s) { Session.new }

  describe '#initialize' do
    it 'sets @session to empty on each initializing' do
      expect(s.session.empty?).to eql(true)
    end
  end

  describe '#add' do
    it 'adds a hash with id and game_id to session array' do
      s.add(123, 'Game Object')
      expect(s.session).to include({ id: 123, game_id: 'Game Object' })
    end
  end

  describe '#start' do
    it 'returns false when the session has not started for that player' do
      s.add(123, 'Game Object')
      id = 12
      expect(s.start?(id)).to eql(false)
    end
    it 'returns true when the session started for that player' do
      s.add(123, 'Game Object')
      id = 123
      expect(s.start?(id)).to eql(true)
    end
  end

  describe '#retrieve' do
    it 'returns the game_id of the session when it exists' do
      s.add(123, 'Game Object')
      expect(s.retrieve(123)).to eql('Game Object')
    end
    it 'returns nil when session do not exists' do
      s.add(123, 'Game Object')
      expect(s.retrieve(12)).to eql(nil)
    end
  end

  describe '#flush' do
    it 'deletes session by id' do
      s.add(123, 'Game Object')
      expect(s.flush(123)).to eql([])
    end
  end
end
