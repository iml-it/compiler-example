require 'php_to_ruby/lexer'
require 'php_to_ruby/parser'
require 'php_to_ruby/code_generator'
require 'php_to_ruby/infix_operator_resolver'

module PhpToRuby

  OPTIMIZERS = [InfixOperatorResolver]

  def self.translate(path_to_input, path_to_output)
    begin
      input = File.read(path_to_input)
      tokens = PhpToRuby::Lexer.lex(input)
      puts '-' * 20
      puts 'Lexer was successful!'
      puts

      ast = PhpToRuby::Parser.parse(tokens)
      puts '-' * 20
      puts 'Parser was successful!'
      puts

      optimized_ast = OPTIMIZERS.inject(ast) do |intermediate_ast, optimizer_class|
        optimizer = optimizer_class.new
        optimizer.visit(intermediate_ast)
      end
      puts '-' * 20
      puts 'Optimization was successful!'
      puts

      code_generator = PhpToRuby::CodeGenerator.new
      File.open(path_to_output, 'w') do |f|
        f << code_generator.visit(optimized_ast)
      end
      puts '-' * 20
      puts 'Code generation was successful!'
      puts
    end
  end

end
