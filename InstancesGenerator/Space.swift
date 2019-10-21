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
		print ("distribute axes in space")
		for axisNr in 0..<axes.count {
			print (axes[axisNr].distribution)
			if axes[axisNr].distribution != 1 {
				axes[axisNr].distributeStyles()
			}
		}
	}
}
