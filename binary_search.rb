require_relative 'Node'

class Tree
    attr_accessor :root
    def initialize(array)
        @root = build_tree(array)
    end

    def build_tree(array)
        return if array.empty?
        if array.length < 2
            return Node.new(array.first)
        end
        array.sort!.uniq!
        mid = (array.length/2).round
        root = Node.new(array[mid])
        root.left_node = build_tree(array.take(mid))
        root.right_node = build_tree(array.drop(mid+1))
        root 
    end

    def insert(node = @root,value)
        return false if node.nil?
        if node.data > value
            if node.left_node
                insert(node.left_node,value)
            else
                node.left_node = Node.new(value)
            end
        else 
            if node.right_node
                insert(node.right_node,value)
            else
                node.right_node = Node.new(value)
            end
        end
    end

    def delete(node = @root, value)
        return node if node.nil?
        if value < node.data
            node.left_node = detete(node.left_node,value)
        elsif value > node.data
            node.right_node = datete(node.right_node,value)
        else
            if node.left_node == nil && node.right_node == nil
                node = nil
            elsif node.left_node == nil
                node = node.right_node
            elsif node.right_node == nil
                node = node.left_node
            end
        end
    end

    def find(node = @root,value)
        return nil if node.nil?
        if node.data == value
            return node
        elsif value > node.data
            find(node.right_node,value)
        else 
            find(node.left_data,value)
        end
    end
    
    def level_order(node = @root,queue = [])
        queue = []
        output = []
        queue << node
        until node.nil?
            output << node.data
            node = queue.shift
            if node.left_node && node.right_node
                queue << node.left_node << node.right_node
            elsif node.left_node
                queue << node.left_node
            elsif node.right_node
                queue << node.right_node
            else
                node = nil
            end
        end
        return output 
           
    end

    def inorder(node = @root, array = [],&block)
        return if node.nil?
        inorder(node.left_node,array, &block)
        block_given? ? yield(node) : array << node.data
        inorder(node.right_node,array, &block)
        array 
    end

    def preorder(node = @root, array = [],&block)
        return if node.nil?
        block_given? ? yield(node) : array << node.data
        preorder(node.left_node,array, &block)
        preorder(node.right_node,array, &block)
        array 
    end

    def postorder(node = @root, array = [],&block)
        return if node.nil?
        postorder(node.left_node,array, &block)
        postorder(node.right_node,array, &block)
        block_given? ? yield(node) : array << node.data
        array 
    end

    def depth(node = @root)
        return -1 if node.nil?
        return [depth(node.left_node), depth(node.right_node)].max + 1
    end

    def balanced?(node = @root)
        return 0 if node.nil?
        left = depth(node.left_node)
        right = depth(node.right_node)
        return false if left.nil? || right.nil?
        if (left-right).abs > 1
            return false
        else
            return true
        end
    end
 
    def rebalance
        @root = build_tree(inorder)
    end       
end 

tree = Tree.new(Array.new(15){rand(1..100)})
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder 
5.times { tree.insert(rand(101..200)) }
p 'Level order'
p tree.level_order
puts "\n"
p 'Check if tree is balanced'
p tree.balanced?
p 'Rebalance tree'
tree.rebalance
p 'Check if tree is balanced'
p tree.balanced?
p 'Level order'
p tree.level_order
puts "\n"
p 'Pre-order'
p tree.preorder
puts "\n"
p 'Inorder'
p tree.inorder
puts "\n"
p 'Post-order'
p tree.postorder
