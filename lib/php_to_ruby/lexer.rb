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
    rule(/\(/) { :L_BRACKET }
    rule(/\)/) { :R_BRACKET }
    rule(/\{/) { :L_CURLY_BRACKET }
    rule(/\}/) { :R_CURLY_BRACKET }

    # operators
    rule(/\*/) { :TIMES }

    # keywords
    rule(/function/) { :FUNCTION }
    rule(/return/) { :RETURN }
    rule(/echo/) { :ECHO }

    rule(/\$[A-Za-z]+/) {|n| [:VARIABLE, n[1..-1]] }
    rule(/[A-Za-z]+/) {|n| [:IDENTIFIER, n]}
    rule(/\d+/) {|t| [:NUMBER, t.to_i]}
  end
end
