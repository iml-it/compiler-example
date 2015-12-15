require 'rltk/lexer'

module PhpToRuby
  class Lexer < RLTK::Lexer
    rule(/\s/) # Ignore whitespace
    rule(/=/) { :ASSIGN }
    rule(/;/) { :SEMICOLON }
  end
end
