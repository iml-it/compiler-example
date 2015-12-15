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

  class Call < Expression
    value :name, String
    child :argument, Expression
  end

  class InfixOperator < Expression
    value :name, String
    child :left, Expression
    child :right, Expression
  end

  class Assignment < Statement
    child :left, Variable
    child :right, Expression
  end

  class Return < Statement
    child :expression, Expression
  end

  class FunctionDeclaration < Statement
    value :name, String
    child :argument, Variable
    child :body, [Statement]
  end

  class Echo < Statement
    child :expression, Expression
  end

  class Program < RLTK::ASTNode
    child :statements, [Statement]
  end

  class Parser < RLTK::Parser
    production(:programm) do
      clause('statement+') {|statements| Program.new(statements) }
    end

    production(:statement) do
      clause('FUNCTION IDENTIFIER L_BRACKET VARIABLE R_BRACKET L_CURLY_BRACKET statement* R_CURLY_BRACKET') do |_, function_name, _, variable_name, _, _, body, _|
        FunctionDeclaration.new(function_name, Variable.new(variable_name), body)
      end
      clause('RETURN expression SEMICOLON') {|_, e, _| Return.new(e)}
      clause('ECHO expression SEMICOLON') {|_, e, _| Echo.new(e)}
      clause('assignment SEMICOLON') {|a, _| a}
    end

    production(:assignment) do
      clause('VARIABLE ASSIGN expression') {|var, _, e| Assignment.new(Variable.new(var), e) }
    end

    production(:expression) do
      clause('VARIABLE') {|name| Variable.new(name)}
      clause('NUMBER') {|n| Number.new(n)}

      clause('IDENTIFIER L_BRACKET expression R_BRACKET') {|name, _, e, _| Call.new(name, e)}

      clause('expression TIMES expression') {|e1, _, e2| InfixOperator.new('*', e1, e2)}
    end

    finalize use: 'php.tbl'
  end
end
