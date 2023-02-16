class Token
  attr_accessor :type, :value, :position

  def initialize(type, value, position)
    @type = type.to_sym
    @value = value
    @position = position
  end

  def ==(value)
    self.value == value
  end

  def node?
    false
  end

  def token?
    true
  end
end