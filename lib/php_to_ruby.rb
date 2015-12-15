require 'php_to_ruby/lexer'
require 'php_to_ruby/parser'

module PhpToRuby

  def self.translate(path_to_input, path_to_output)
    input = File.read(path_to_input)
    tokens = PhpToRuby::Lexer.lex(input)
    p PhpToRuby::Parser.parse(tokens)
  end

end
