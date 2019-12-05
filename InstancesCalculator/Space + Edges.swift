import Foundation

extension SpaceProtocol {
	var edges: [[EdgeProtocol]] {
		return Edge.allEdgesForSpace(dimensions)
	}
}

