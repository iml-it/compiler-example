require 'filigree/visitor'

module PhpToRuby
  class BaseOptimizer
    include Filigree::Visitor

    on _ do |node|
      # optimize children
      node.children(Hash).each do |child_name, child_node|
        if child_node.is_a?(Array)
          mapped_children = child_node.map {|child| visit(child)}
          node.children = {child_name => mapped_children}
        else
          node.children = {child_name => visit(child_node)}
        end
      end

      # return the optimized node
      node
    end
  end
end
