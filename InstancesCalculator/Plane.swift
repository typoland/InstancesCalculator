import Foundation

protocol PlaneProtocol {
	var edgesA: (EdgeProtocol, EdgeProtocol) {get set}
	var edgesB: (EdgeProtocol, EdgeProtocol) {get set}
	init (edgesA: (EdgeProtocol, EdgeProtocol), edgesB:(EdgeProtocol, EdgeProtocol))
}

extension PlaneProtocol {
	static func definePlanes (for edges:[[EdgeProtocol]]) -> [[Self]] {
		var result: [[Self]] = []
		for axisNr in 0..<edges.count {
			let nextAxis = (axisNr+1) % edges.count
			var planes: [Self] = []
			for pairNr in 0..<(edges[axisNr].count/2) {
				let e1 = (edges[axisNr][pairNr*2],
						  edges[axisNr][pairNr*2+1])
				let e2 =  (edges[nextAxis][pairNr],
						   edges[nextAxis][pairNr+edges[axisNr].count/2])
				planes.append(Self(edgesA: e1, edgesB: e2))
			}
			result.append(planes)
		}
		return result
	}
}

extension PlaneProtocol {

	var description: String {
		return "Plane: \(edgesA), \(edgesB)"
	}
	
	var belongsToAxes: (Int, Int) {
		return ((edgesA.0.from ^ edgesA.0.to).log2!, (edgesB.0.from ^ edgesB.0.to ).log2!)
	}
}

struct Plane: PlaneProtocol, CustomStringConvertible {
	var edgesA: (EdgeProtocol, EdgeProtocol)
	var edgesB: (EdgeProtocol, EdgeProtocol)
	init (edgesA: (EdgeProtocol, EdgeProtocol), edgesB:(EdgeProtocol, EdgeProtocol)) {
		self.edgesA = edgesA
		self.edgesB = edgesB
	}
}
