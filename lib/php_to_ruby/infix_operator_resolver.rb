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
      if node.left.is_a?(Number) && node.right.is_a?(Number)
        Number.new(eval("#{node.left.value} #{node.name} #{node.right.value}"))
      else
        node
      end
    end

  end
end
