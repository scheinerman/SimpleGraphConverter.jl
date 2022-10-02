using Test, SimpleGraphs, Graphs, SimpleGraphConverter

@testset "SimpleGraph to UndirectedGraph" begin
    g = path_graph(10)
    G = UG(g)
    @test G == Path(10)

    g = cycle_graph(8)
    G = UndirectedGraph(g)
    @test G == Cycle(8)
end


@testset "UndirectedGraph to SimpleGraph" begin
    G = Path(10)
    g = SimpleGraph(G)
    @test g == path_graph(10)

    G = Cycle(8)
    g = SimpleGraph(G)
    @test g == cycle_graph(8)
end