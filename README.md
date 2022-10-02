# SimpleGraphConverter

This package convertes graphs between the 
[`Graphs`](https://github.com/JuliaGraphs/Graphs.jl) and 
[`SimpleGraphs`](https://github.com/scheinerman/SimpleGraphs.jl.git) modules.

## Overview

The Julia modules `Graphs` [formerly `LightGraphs`] and `SimpleGraphs` can be used for graph theory computations. 
Simple graphs (graphs without directions, loops, or multiple edges) are defined in both modules.

* In `Graph` the datatype is `SimpleGraph`.
* In `SimpleGraphs` the data type is `UndirectedGraph` (which may be abbreviated `UG`).

This `SimpleGraphConverter` module helps with conversion from one type to the other. 

* If `g` is a `SimpleGraph`, then `UndirectedGraph(g)` [or `UG(g)`] converts the graph to type `UndirectedGraph`.
* If `G` is an `UndirectedGraph`, then `SimpleGraph(G)` converts the graph to a `SimpleGraph`.

## Examples

#### Converting a `SimpleGraph` to an `UndirectedGraph`

```
julia> using Graphs, SimpleGraphs, SimpleGraphConverter

julia> g = cycle_graph(6)
{6, 6} undirected simple Int64 graph

julia> G = UG(g)
UndirectedGraph{Int64} (n=6, m=6)

julia> G == Cycle(6)
true
```

#### Converting an `UndirectedGraph` to a `SimpleGraph`

```
julia> G = Path(9)
Path (n=9, m=8)

julia> g = SimpleGraph(G)
{9, 8} undirected simple Int64 graph

julia> g == path_graph(9)
true
```

## Loss of vertex names


The vertices of a `SimpleGraph` (from the `Graphs` module) is always a 
set of integers of the form `{1,2,...,n}`. 
The vertex set of an `UndirectedGraph` can contain
arbitrary types. 
When converting from a `SimpleGraph` to an `UndirectedGraph`, the names
of the vertices are converted to consecutive integers. 

In this example, the `Petersen()` function returns the Petersen graph as an `UndirectedGraph`. The ten vertices are the two-element subsets of `{1,2,3,4,5}`.
When we convert to a `SimpleGraph`, the resulting graph has ten vertices that are the integers from `1` to `10`. When we convert that `SimpleGraph` back to an `UndirectedGraph`, the 
vertices are different (integers vs. two-element sets) from the original. 

```
julia> using ShowSet

julia> G = Petersen()
Petersen (n=10, m=15)

julia> g = SimpleGraph(G)
{10, 15} undirected simple Int64 graph

julia> H = UG(g)
UndirectedGraph{Int64} (n=10, m=15)

julia> G == H  
false

julia> using SimpleGraphAlgorithms

julia> is_iso(G,H)   # lots of output deleted
true
```