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
	RobotId int
}


type state struct {
	RobotId int
	RobotLocation string
	Pickup []parcel
	Loaded []parcel
	Delivered []parcel
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
		RobotId: 1,
		RobotLocation: "NW",
		Pickup: parcels,
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


func load(current state) {
	// Checks the current state for Pickup parcels at the robot location.
	// Sets the RobotId for the parcel to indicate that it is loaded.
	// Moves the parcel from the Pickup to the Loaded state 
}


func move(current state, destination string) state {

	return current
}


func unload(current state) {
	// Checks the Loaded state for parcels destined for the robot location.
	// Moves parcels from the Loaded to the Delivered state.
	

}


func main() {
	graph := buildGraph(roads)
	fmt.Printf("graph: %v\n", graph)	
	// var current state = initialState

}