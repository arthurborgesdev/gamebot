class Session 
  attr_reader :session

  def initialize
    @session = []
  end

  def add(id, command)
    session.push({id: id, command: command})
  end

  def scan(id)
    session.filter { |session| session[:id] == id }
  end
end
