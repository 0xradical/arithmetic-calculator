class Lexer
  def initialize(expr)
    @expr = expr
    @length = expr.length
    @p = 0
    @tokens = []
  end

  def ended?
    @p == @length
  end

  def consume
    char = @expr[@p]
    @p = @p + 1
    char
  end

  def lookahead(n = 0)
    @expr[@p + n]
  end

  def tokenize
    loop do
      break if ended?

      char = consume
      position = @p - 1

      if char == " "
        next
      elsif ["+", "-", "*", "/"].include?(char)
        @tokens << Token.new(:op, char, position)
      elsif char =~ /[0-9]/
        number = char

        while lookahead =~ /[0-9]/
          number = number + consume
        end

        @tokens << Token.new(:number, number, position)
      else
        raise "Syntax Error: Invalid character #{char.inspect}"
      end
    end

    @tokens << Token.new(:eof, nil, @p - 1)

    @tokens
  end
end