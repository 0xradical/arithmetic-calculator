class Interpreter
  attr_reader :ast, :stack, :code, :cp

  def initialize(ast, debug: false)
    @ast = ast
    @stack = []
    @code = []
    @cp = 0
    @debug = debug
  end

  def ended?
    @cp == @code.length
  end

  def compile
    codeop(@ast.left)
    codeop(@ast.right)
    codeop(@ast.token)

    @code
  end

  def codeop(value)
    if value.node?
      codeop(value.left)
      codeop(value.right)
      codeop(value.token)
    else # token
      if value.type == :op
        @code << [:op, value.value]
      else
        @code << [:push, value.value]
      end
    end
  end

  def run
    loop do
      break if ended?

      op, val = @code[@cp]

      # debug stack
      if @debug
        print "# "
        puts @stack.map{|entry| " #{entry} "}.join(" | ")
      end

      if op == :push
        @stack.push(val)
      else
        right = Integer(@stack.pop)
        left = Integer(@stack.pop)

        result = case val
        when "+"
          left + right
        when "-"
          left - right
        when "*"
          left * right
        when "/"
          left / right
        end

        @stack.push(result)
      end

      @cp = @cp + 1
    end

    @stack[-1]
  end
end