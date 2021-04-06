class Session 
  attr_reader :session

  def initialize
    @session = []
  end

  def add(id, game_id, command)
    session.push({id: id, game_id: game_id, command: command})
  end

  def scan(id)
    session.filter { |session| session[:id] == id }
  end

  def start?(id, command)
    session.filter { |session| session[:id] == id }
           .any? { |session| session[:command] == command} 
  end

  def game_session(id)
    session.filter { |session| session[:id] == id }.first[:game_id]
  end
end
