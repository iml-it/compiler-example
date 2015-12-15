require 'php_to_ruby/lexer'
require 'php_to_ruby/parser'
require 'php_to_ruby/code_generator'

module PhpToRuby

  def self.translate(path_to_input, path_to_output)
    begin
      input = File.read(path_to_input)
      tokens = PhpToRuby::Lexer.lex(input)
      ast = PhpToRuby::Parser.parse(tokens)
      compiler = PhpToRuby::CodeGenerator.new
      File.open(path_to_output, 'w') do |f|
        f << compiler.visit(ast)
      end
    end
  end

end
