require 'rltk/lexer'

module PhpToRuby
  class Lexer < RLTK::Lexer
    # php definition
    rule(/\<\?php/)

    # comments
    rule(/\/\//) { push_state(:comment) }
    rule(/\n/, :comment) { pop_state }
    rule(/./, :comment)

    # special characters
    rule(/\s/) # Ignore whitespace
    rule(/=/) { :ASSIGN }
    rule(/;/) { :SEMICOLON }

    rule(/\$[A-Za-z]+/) {|n| [:VARIABLE, n[1..-1]] }
    rule(/\d+/) {|t| [:NUMBER, t.to_i]}
  end
end
