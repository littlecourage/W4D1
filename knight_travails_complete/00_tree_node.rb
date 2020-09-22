require "byebug"

class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        old_parent = @parent
        @parent = parent_node
        if !self.parent.nil?

            if !old_parent.nil? && old_parent != self.parent
                old_parent.children.delete_if { |child| child == self }
            end

            self.parent.children << self if !self.parent.children.include?(self)
        end
        
    end

    def add_child(child_node)
        child_node.parent=(self)
    end

    def remove_child(child_node)
        raise 'not a child' if child_node.parent.nil?
        child_node.parent=(nil)
    end

    #Searchable

    def dfs(target_value)
        # debugger
        if self.value == target_value
            return self 
        else

            self.children.each do |child|
                result = child.dfs(target_value)
                # debugger
                return result if !result.nil?
            end
        end
        return nil
    end

    def inspect
        self.value
    end

    def bfs(target_value)
        #debugger
        queue = [self]
     
        while !queue.empty?
            first = queue.shift
            if first.value == target_value
                return first
            else
                queue += first.children
            end

        end
        return nil
    end

end

# class Searchable 

    

# end