require 'php_to_ruby/base_optimizer'

module PhpToRuby
  class ConstantResolver < BaseOptimizer

    def initialize
      @constants = {}
    end

    on ConstantDefinition do |node|
      # optimize the expression
      node.children = {
        right: visit(node.right)
      }

      if node.right.is_a?(Number)
        # constant definition can be removed becuase it will be replaced everywhere
        @constants[node.left.name] = node.right
        nil
      else
        # return the unchanged node
        node
      end
    end

    on Constant do |node|
      if @constants.include?(node.name)
        @constants[node.name]
      else
        node
      end
    end

  end
end
