require_relative "00_tree_node.rb"
require "byebug"
class KnightPathFinder

    def self.valid_moves(pos)
        moves = [ [-2, -1],[-2,  1],[-1, -2],[-1,  2],[ 1, -2],[ 1,  2],[ 2, -1],[ 2,  1] ]
        possible_moves = []
        moves.each do |ele|
            x, y = pos
            possible_moves << [ele[0] + x, ele[1]+y]
        end
        possible_moves.delete_if { |ele| ele[0] > 7 || ele[1] > 7 || ele[0] < 0 || ele[1] < 0 }
        return possible_moves
    end
    
    def initialize(start_pos_arr)
        # debugger
        @start_pos = start_pos_arr
        # debugger
        @considered_positions = [start_pos_arr]
        self.build_move_tree
        # debugger
    end
    
    attr_accessor :root_node, :considered_positions

    def build_move_tree
        # debugger
        self.root_node = PolyTreeNode.new(@start_pos)
        move_queue = [self.root_node]

        until move_queue.empty?
            current_node = move_queue.shift
            # debugger
            cur_node_val = current_node.value
            moves = new_move_positions(cur_node_val)
            moves.each do |pos|
                new_node = PolyTreeNode.new(pos)
                current_node.add_child(new_node)
                move_queue << new_node
            end
            # move_queue += current_node.children

        end

    end
    
    def new_move_positions(pos)
        possible_moves = KnightPathFinder.valid_moves(pos).delete_if do |ele|
            # debugger
            @considered_positions.include?(ele)
        end
        @considered_positions.concat(possible_moves)
        return possible_moves
    end

    def inspect
        self.root_node
    end

    def find_path(end_pos)
        #return target node
        end_node = self.root_node.dfs(end_pos)
        return trace_path_back(end_node)
    end

    def trace_path_back(node)
        return [self.root_node.value] if node.parent.nil?
        # until node.parent.nil? # [7, 7] => [5, 6]
        return trace_path_back(node.parent) << node
        # end
    end

end
    # p kpf = KnightPathFinder.new([0, 0])
    # #p kpf.considered_positions.count

    # p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
    # p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]  
    # @root_node = PolyTreeNode.new(@starting_pos)

# p kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]