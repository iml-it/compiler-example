require 'rltk/lexer'

module PhpToRuby
  class Lexer < RLTK::Lexer
    rule(/\s/) # Ignore whitespace
    rule(/=/) { :ASSIGN }
    rule(/;/) { :SEMICOLON }

    rule(/\$[A-Za-z]+/) { :VARIABLE }

    rule(/\d+/) {|t| [:NUMBER, t.to_i]}
  end
end
