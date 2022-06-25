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
	
	for _, r := range edges {
		// Test if From is key in graph.
		_, ok := graph[r.From]
		// From is not in graph. Add it as key.
		if !ok {
			// Create empty slice as value.
			s := []string{}
			graph[r.From] = s 
		}

		// Add r.To to list of paths from r.From
		graph[r.From] = append(graph[r.From], r.To)

		// Test if To is key in graph
		_, ok = graph[r.To]
		if !ok {
			s := []string{}
			graph[r.To] = s
		}

		graph[r.To] = append(graph[r.To], r.From)
	}

	return graph
}


func main() {
	graph := buildGraph(roads)
	fmt.Printf("graph: %v\n", graph)
}