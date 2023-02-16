require_relative "./token.rb"
require_relative "./node.rb"
require_relative "./lexer.rb"
require_relative "./parser.rb"
require_relative "./interpreter.rb"

expr = "2 + 3 * 5 / 6 - 8"

tokens = Lexer.new(expr).tokenize
# pp tokens
ast = Parser.new(tokens).parse
# pp ast
interpreter = Interpreter.new(ast)
code = interpreter.compile
# pp code
result = interpreter.run
puts "#{expr} = #{result}"