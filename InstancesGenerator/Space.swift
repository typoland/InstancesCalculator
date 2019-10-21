import Foundation

struct Space {
	var axes: [Axis] = []
	var dimensions: Int {
		return axes.count
	}
	init (axes:[Axis]) {
		self.axes = axes
	}
	var verticesNr: Int {
		return 1<<dimensions
	}
	
	mutating func distributeAxes() {
		(0..<axes.count).forEach { axes[$0].distributeStyles() }
	}
}
