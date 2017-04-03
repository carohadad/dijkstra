require_relative '../graph'

RSpec.describe Graph do

  before (:each) do
    @graph = Graph.new(3)
    @graph.add_node("A")
    @graph.add_node("B")
    @graph.add_node("C")

    @graph.add_edge("A", "B", 1)
    @graph.add_edge("A", "C", 2)
  end

  it "should create a graph with nodes" do

    expect(@graph.nodes).to eq([
      {:name=>"A", :index_in_matrix=>0},
      {:name=>"B", :index_in_matrix=>1},
      {:name=>"C", :index_in_matrix=>2}
    ])
    expect(@graph.adjacency_matrix).to eq([
      [0, 1, 2],
      [1, 0, nil],
      [2, nil, 0]
    ])

  end

  it "should return neighbors but not self" do
    node_a = @graph.find_node("A")
    neighbors = @graph.neighbors_with_weight(node_a)
    expect(neighbors).to eq([
      {index_in_matrix: 1, weight: 1},
      {index_in_matrix: 2, weight: 2}
    ])

    expect(neighbors).not_to include (
      {index_in_matrix: 0, weight: 0}
    )
  end

  it "should return neighbors that are reacheable" do
    graph_2 = Graph.new(3)
    graph_2.add_node("A")
    graph_2.add_node("B")
    graph_2.add_node("C")

    graph_2.add_edge("A", "B", 3)

    node_a = graph_2.find_node("A")
    neighbors = graph_2.neighbors_with_weight(node_a)

    expect(neighbors).not_to include (
      {index_in_matrix: 2, weight: 2}
    )
  end

  it "should calculate shortest path in a 2 nodes graph" do
    value = @graph.find_shortest_path("A", "C")
    expect(value).to eq(2)
  end

  it "shortest path is infinity if the nodes are not connected" do
    graph_unconected = Graph.new(3)
    graph_unconected.add_node("A")
    graph_unconected.add_node("B")
    graph_unconected.add_node("C")

    graph_unconected.add_edge("A", "B", 3)

    value = graph_unconected.find_shortest_path("A", "C")
    expect(value).to eq(Float::INFINITY)
  end

  it "shortest path in graph with 2 different paths" do
    graph_5 = Graph.new(5)
    graph_5.add_node("A")
    graph_5.add_node("B")
    graph_5.add_node("C")
    graph_5.add_node("D")
    graph_5.add_node("E")

    graph_5.add_edge("A", "B", 1)
    graph_5.add_edge("B", "C", 1)
    graph_5.add_edge("B", "D", 2)
    graph_5.add_edge("D", "E", 2)
    graph_5.add_edge("C", "E", 5)

    expect(graph_5.find_shortest_path("A", "E")).to eq(5)
  end

   it "shortest path when decission needs to be changed at the end" do
    graph_6 = Graph.new(6)
    graph_6.add_node("A")
    graph_6.add_node("B")
    graph_6.add_node("C")
    graph_6.add_node("D")
    graph_6.add_node("E")
    graph_6.add_node("F")

    graph_6.add_edge("A", "B", 1)
    graph_6.add_edge("B", "C", 1)
    graph_6.add_edge("B", "D", 2)
    graph_6.add_edge("D", "E", 2)
    graph_6.add_edge("C", "E", 5)
    graph_6.add_edge("E", "F", 100)
    graph_6.add_edge("D", "F", 5)

    expect(graph_6.find_shortest_path("A", "F")).to eq(8)
  end
end
