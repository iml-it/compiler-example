require 'rltk/parser'
require 'rltk/ast'

module PhpToRuby
  class Expression < RLTK::ASTNode
  end
  class Statement < RLTK::ASTNode
  end

  class Variable < Expression
    value :name, String
  end
  class Number < Expression
    value :value, Integer
  end

  class Assignment < Statement
    child :left, Variable
    child :right, Expression
  end

  class Program < RLTK::ASTNode
    child :statements, [Statement]
  end

  class Parser < RLTK::Parser
    production(:program) do
      clause('statement*') {|statements| Program.new(statements)}
    end

    production(:statement) do
      clause('variable_assignment SEMICOLON') {|d, _| d}
    end

    production(:variable_assignment) do
      clause('VARIABLE ASSIGN expression') {|var, _, e| Assignment.new(Variable.new(var), e) }
    end

    production(:expression) do
      clause('NUMBER') {|n| Number.new(n)}
    end

    finalize use: 'php.tbl'
  end
end
