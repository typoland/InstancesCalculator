import Foundation

public protocol AxisInstanceProtocol {
	associatedtype CoordUnit: FloatingPoint & Decodable & Encodable
	var name: String {get set}
	var values: [CoordUnit] {get set}
	init (name: String, values: [CoordUnit])
}

public protocol AxisProtocol {
	associatedtype AxisInstance: AxisInstanceProtocol
	var name: String {get set}
	var styles: [AxisInstance] {get set}
	var bounds: ClosedRange<AxisInstance.CoordUnit> {get set}
	var distribution: AxisInstance.CoordUnit? {get set}
	init (name: String,
		  bounds: ClosedRange<AxisInstance.CoordUnit>,
	      styles: [AxisInstance])
}

public protocol SpaceProtocol {
	associatedtype Axis: AxisProtocol
	var axes: [Axis] {get set}
	init (axes: [Axis])
	//init (axes names: [String], bounds: ClosedRange<Axis.AxisInstance.CoordUnit>)
}

extension SpaceProtocol {
	var dimensions: Int {
		return axes.count
	}
	
	var verticesNr: Int {
		return 1<<dimensions
	}
	
	mutating func distributeAxes() {
		(0..<axes.count).forEach { axes[$0].distributeStyles() }
	}
}

struct Space<CU:FloatingPoint & Codable>: SpaceProtocol {
	
	typealias Axis = IGAxis<IGStyle<CU>>

	var axes: [Axis] = []
	init (axes:[Axis]) {
		self.axes = axes
	}
//	var dimensions: Int {
//		return axes.count
//	}

//	var verticesNr: Int {
//		return 1<<dimensions
//	}
	
//	mutating func distributeAxes() {
//		(0..<axes.count).forEach { axes[$0].distributeStyles() }
//	}
}
