require_relative "graph"

def create_graph
  puts "Enter number of nodes"
  node_number_string = gets.chomp
  node_number = node_number_string.to_i

  alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  nodes = alphabet[0..node_number-1]

  puts "Nodes will be called: #{nodes.chars.join(",")}"

  graph = Graph.new(node_number)

  nodes.each_char do |letter|
    graph.add_node(letter)
  end

  nodes.each_char.with_index  do | letter, letter_index|
    alphabet[letter_index+1..node_number-1].each_char do | letter_connected_to |
      puts "Weight between #{letter} and #{letter_connected_to} (or nothing if unconected):"
      weight = gets.chomp
      if !weight.empty?
        graph.add_edge(letter, letter_connected_to, weight.to_i)
      end
    end
  end

  return graph
end

graph = create_graph()
puts "Find shortest path from:"
from = gets.chomp
puts "Find shortest path to:"
to = gets.chomp

value = graph.find_shortest_path(from, to)

puts "Shortest path weight is: #{value}"



