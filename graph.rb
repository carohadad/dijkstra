class Graph
  attr_accessor :nodes
  attr_accessor :adjacency_matrix

  def initialize(number_of_nodes)
    @nodes = []
    @adjacency_matrix = []
    number_of_nodes.times do || 
      @adjacency_matrix  << Array.new(number_of_nodes, nil)
    end
  end

  def add_node(name)
    index = @nodes.count
    @nodes << {name: name, index_in_matrix: index}
    @adjacency_matrix[index][index] = 0
  end

  def add_edge(node_from_name, node_to_name, weight)
    node_from_index = find_node(node_from_name)[:index_in_matrix]
    node_to_index = find_node(node_to_name)[:index_in_matrix]

    @adjacency_matrix[node_from_index][node_to_index] = weight
    @adjacency_matrix[node_to_index][node_from_index] = weight
  end

  def find_node(node_name)
    @nodes.find{|node| node[:name] == node_name}
  end


  def print
    @adjacency_matrix.inspect
  end

  def find_shortest_path(from_name, to_name)
    puts "TODO"
  end

end