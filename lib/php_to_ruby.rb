require 'php_to_ruby/lexer'

module PhpToRuby

  def self.translate(path_to_input, path_to_output)
    input = File.read(path_to_input)
    p PhpToRuby::Lexer.lex(input)
  end

end
