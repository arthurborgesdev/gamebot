class Session
  attr_reader :session

  def initialize
    @session = []
  end

  def add(id, game_id)
    session.push({ id: id, game_id: game_id })
  end

  def scan(id)
    session.filter { |session| session[:id] == id }
  end

  def start?(id)
    session.any? { |session| session[:id] == id }
  end

  def retrieve(id)
    game_session = session.find { |session| session[:id] == id }
    game_session[:game_id]
  end

  def flush(id)
    session.delete_if { |session| session[:id] == id }
  end
end
