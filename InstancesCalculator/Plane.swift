import Foundation


struct Plane: CustomStringConvertible {
	var edgesA: (Edge, Edge)
	var edgesB: (Edge, Edge)
	init (edgesA: (Edge, Edge), edgesB:(Edge, Edge)) {
		self.edgesA = edgesA
		self.edgesB = edgesB
	}
	var description: String {
		return "Plane: \(edgesA), \(edgesB)"
	}
	
	var belongsToAxes: (Int, Int) {
		return ((edgesA.0.from ^ edgesA.0.to).log2!, (edgesB.0.from ^ edgesB.0.to ).log2!)
	}
}
