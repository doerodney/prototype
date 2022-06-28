package main

import (
	"fmt"
)

type road struct {
	From string
	To string
}

var roads []road

func init() {
	roads = []road {
		{
			From: "NW",
			To: "NE",
		},
		{
			From: "NW",
			To: "SW",
		},
		{
			From: "NE",
			To: "SE",
		},
		{
			From: "SW",
			To: "SE",
		},
		{
			From: "SW",
			To: "NE",
		},
	}
}


func buildGraph(edges []road) map[string][]string {
	graph := make(map[string][]string)

	var addEdge = func(from string, to string) {
		_, ok := graph[from]
		if !ok {
			s := []string{}
			graph[from] = s
		}
		graph[from] = append(graph[from], to)
	}
	
	for _, r := range edges {
		addEdge(r.From, r.To)
		addEdge(r.To, r.From)
	}

	return graph
}


func main() {
	graph := buildGraph(roads)
	fmt.Printf("graph: %v\n", graph)
}