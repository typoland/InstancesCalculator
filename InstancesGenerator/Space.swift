import Foundation

public struct Space {
	public var axes: [Axis] = []
	public var dimensions: Int {
		return axes.count
	}
	public init (axes:[Axis]) {
		self.axes = axes
	}
	public var verticesNr: Int {
		return 1<<dimensions
	}
}
