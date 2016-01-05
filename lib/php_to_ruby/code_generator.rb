require 'filigree/visitor'

module PhpToRuby
  class CodeGenerator
    include Filigree::Visitor

    on Program do |node|
      node.statements.map do |statement|
        visit statement
      end.join("\n")
    end

    on FunctionDeclaration do |node|
      result = ''
      result << "def #{node.name}(#{visit node.argument})\n"
      node.body.each do |statement|
        result << visit(statement)
        result << "\n"
      end
      result << "end\n"
    end

    on Echo do |node|
      "puts #{visit node.expression}"
    end

    on Return do |node|
      "return #{visit node.expression}"
    end

    on ConstantDefinition do |node|
      "#{visit node.left} = #{visit node.right}"
    end

    on Assignment do |node|
      "#{visit node.left} = #{visit node.right}"
    end

    on Call do |node|
      "#{node.name}(#{visit node.argument})"
    end

    on InfixOperator do |node|
      "#{visit node.left} #{node.name} #{visit node.right}"
    end

    on Variable do |node|
      node.name
    end

    on Constant do |node|
      node.name
    end

    on Number do |node|
      node.value
    end
  end
end
