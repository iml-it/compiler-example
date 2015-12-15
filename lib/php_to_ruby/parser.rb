require 'rltk/parser'
require 'rltk/ast'

module PhpToRuby
  class Variable < RLTK::ASTNode
    value :name, String
  end
  class Number < RLTK::ASTNode
    value :value, Integer
  end

  class Assign < RLTK::ASTNode
    child :left, Variable
    child :right, Number
  end

  class Parser < RLTK::Parser
    production(:statement) do
      clause('declaration SEMICOLON') {|d, _| d}
    end
    production(:declaration) do
      clause('VARIABLE ASSIGN NUMBER') {|var, _, number| Assign.new(Variable.new(var), Number.new(number)) }
    end
    finalize use: 'php.tbl'
  end
end
