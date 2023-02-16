##
#  Grammar
#
#  expr -> factor ( ( "+" | "-" ) expr )*
# factor -> number ( ("*" | "/") factor )*
#

class Parser
  def initialize(tokens)
    @tokens = tokens
    @p = 0
  end

  def consume
    token = @tokens[@p]
    @p = @p + 1
    token
  end

  def lookahead(n = 0)
    @tokens[@p + n]
  end

  def parse
    expr
  end

  def expr
    node = factor

    if lookahead && ( lookahead == "+" || lookahead == "-" )
      node = Node.new(consume, node, expr)
    end

    node
  end

  def factor
    node = consume

    if node.type != :number
      raise "Syntax Error: Invalid type at position #{node.position}: #{node.value.inspect} of type #{node.type}"
    else
      if lookahead && ( lookahead == "*" || lookahead == "/" )
        node = Node.new(consume, node, factor)
      end
    end

    node
  end
end
