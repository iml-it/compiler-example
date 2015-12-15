# require 'rltk/cg/contractor'
require 'filigree/visitor'

module PhpToRuby
  class CodeGenerator
    include Filigree::Visitor

    on Program do |node|
      node.statements.map do |statement|
        visit statement
      end.join("\n")
    end

    on Assignment do |node|
      "#{visit node.left} = #{visit node.right}"
    end

    on Variable do |node|
      node.name
    end

    on Number do |node|
      node.value
    end
  end
end
