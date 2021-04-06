class Session 
  attr_reader :session

  def initialize
    @session = []
  end

  def add(id, command)
    session << [id, command]
  end

  def compare(id)
  end 
end
