class Node
    include Comparable
    attr_accessor :right_node, :left_node, :data, :nodes 
    def initialize(data)
        @data = data
        @right_node = nil
        @left_node = nil
    end

    def <=>(other_node)
        @data <=> other_node
    end
end
