require_relative '../graph'

RSpec.describe Graph do
  it "should create a graph with nodes" do
    graph = Graph.new(3)
    graph.add_node("A")
    graph.add_node("B")
    graph.add_node("C")

    graph.add_edge("A", "B", 1)
    graph.add_edge("A", "C", 2)

    expect(graph.nodes).to eq([
      {:name=>"A", :index_in_matrix=>0}, 
      {:name=>"B", :index_in_matrix=>1}, 
      {:name=>"C", :index_in_matrix=>2}
    ])
    expect(graph.adjacency_matrix).to eq([
      [0, 1, 2], 
      [1, 0, nil], 
      [2, nil, 0]
    ])

  end
end
