class Node
  attr_accessor :token, :left, :right

  def initialize(token, left, right)
    @token, @left, @right = token, left, right
  end

  def node?
    true
  end

  def token?
    false
  end
end