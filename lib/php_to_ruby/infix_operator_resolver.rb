require 'php_to_ruby/base_optimizer'

module PhpToRuby
  class InfixOperatorResolver < BaseOptimizer

    on InfixOperator do |node|
      # optimize the children first
      node.children = {
        left: visit(node.left),
        right: visit(node.right)
      }

      # return the optimized node
      node
    end
  end
end
