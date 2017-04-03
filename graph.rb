require 'set'

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

  def neighbors_with_weight(node)
    res = []
    @adjacency_matrix[node[:index_in_matrix]].each_with_index do |value, index|

      #Does not include self in neighbors or unreachable nodes
      if (index != node[:index_in_matrix] and value != nil)
        res << {index_in_matrix: index, weight: value}
      end

    end
    res
  end


  def print
    @adjacency_matrix.inspect
  end

  def find_shortest_path(from_name, to_name)
    from = find_node(from_name)
    to = find_node(to_name)

    min_distances_to_target = Array.new(@nodes.count)
    @nodes.each do |node|
      min_distances_to_target[node[:index_in_matrix]] = {name: node[:name], index_in_matrix: node[:index_in_matrix], value: Float::INFINITY}
    end

    unvisited = @nodes.map{|node| node[:name]}

    min_distances_to_target[from[:index_in_matrix]][:value] = 0 # Min distance from source to source is zero

    while (!unvisited.empty?)

      next_node = min_distances_to_target.find_all{|n| unvisited.include?(n[:name])}.min_by {|node| node[:value]}
      unvisited.delete(next_node[:name])

      break if (next_node[:name] == to_name || min_distances_to_target[next_node[:index_in_matrix]][:value] == Float::INFINITY)

      neighbors = neighbors_with_weight(next_node)

      neighbors.each do |neighbor|
        distance_through_this_neighbor = min_distances_to_target[next_node[:index_in_matrix]][:value] + neighbor[:weight]

        if (distance_through_this_neighbor < min_distances_to_target[neighbor[:index_in_matrix]][:value])
          min_distances_to_target[neighbor[:index_in_matrix]][:value] = distance_through_this_neighbor

        end
      end
    end


    min_distances_to_target[to[:index_in_matrix]][:value]
  end

end
