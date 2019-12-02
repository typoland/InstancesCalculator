import Foundation

extension SpaceProtocol {
	var edges: [[Edge]] {
		var result:[[Edge]] = []
		for axisNr in (0..<dimensions) {
			var axisResult:[Edge] = []
			for vertexNr in 0 ..< verticesNr>>1 {
				let v1 = (vertexNr << 1)
				let v2 = ((vertexNr << 1) + 1)
				let b1 = v1  <<> (dimensions, axisNr)
				let b2 = v2  <<> (dimensions, axisNr)
				axisResult.append(Edge(from:b1, to:b2))
			}
			result.append(axisResult)
		}
		return result
	}
}

