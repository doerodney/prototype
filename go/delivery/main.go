/*--
Graph exercise in which a robot moves through a virtual space.  
At each location, it unloads then load parcels, as necessary.

--*/

package main

import (
	"fmt"
)

type road struct {
	From string
	To string
}

type parcel struct {
	At string
	To string
}

type state struct {
	robotLocation string
	parcels []parcel
}

var roads []road

func init() {
	roads = []road {
		{
			From: "NW",
			To: "NC",
		},
		{
			From: "NC",
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
			To: "SC",
		},
		{
			From: "SC",
			To: "SE",
		},
		{
			From: "SW",
			To: "NE",
		},
	}
}


var initialState state
func init() {
	parcels := []parcel {
		{
			At: "NW",
			To: "SE",
		},
		{
			At: "NW",
			To: "NE",
		},
		{
			At: "SW",
			To: "NE",
		},
	}

	initialState = state {
		robotLocation: "NW",
		parcels: parcels,
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


// func move(current state, destination string) state {

// 	return current
// }

func main() {
	graph := buildGraph(roads)
	fmt.Printf("graph: %v\n", graph)	
	// var current state = initialState

}