require 'php_to_ruby/lexer'
require 'php_to_ruby/parser'
require 'php_to_ruby/code_generator'

module PhpToRuby

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

      code_generator = PhpToRuby::CodeGenerator.new
      File.open(path_to_output, 'w') do |f|
        f << code_generator.visit(ast)
      end
      puts '-' * 20
      puts 'Code generation was successful!'
      puts
    end
  end

end
