# Description
This is a graph-centric simulation of the robots I have seen wandering around silicon wafer fabrication plans (fabs).  This simulation is implemented in Golang.

In this simulation, a robot is given a list that describes parcels that is must pick up and deliver to locations in a fab.  The locations are described in a graph, with the locations as the vertices, and the paths between locations as the edges of the graph.

This problem could get very interesting, in particular, for calculating/discovering optimal routes.  Could be the basis for a chess simulator.

## Locations
Locations in this simulation are give names that are geographic, i.e., NW is the northwest corner, and NE is the northeast corner.  NC is north central; there is no North Carolina in this simulation.

## Robot Identifier
A RobotId of 0 indicates that no robot is assigned to a parcel.  Robot identifiers are positive, non-zero integers.  To make this interesting, I might add more robots to the simulation.