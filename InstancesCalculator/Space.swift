import Foundation

public protocol AxisInstanceProtocol {
	associatedtype CoordUnit: FloatingPoint & Decodable & Encodable
	var name: String {get set}
	var values: [CoordUnit] {get set}
	init (name: String, values: [CoordUnit])
}

extension AxisInstanceProtocol {
	
	mutating func addValuesForNewAxis() {
		values = values+values
	}
	
	mutating func removeValuesForLastAxis() {
		values = Array(values[0..<values.count/2])
	}
}

public protocol AxisProtocol: Hashable {
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
}

extension SpaceProtocol {
	var dimensions: Int {
		return axes.count
	}
	
	static func vertices(of dimensions:Int) -> Int {
		return 1<<dimensions
	}
	
	var verticesNr: Int {
		return Self.vertices(of: dimensions)
	}
	
	mutating func distributeAxes() {
		(0..<axes.count).forEach { axes[$0].distributeStyles() }
	}
}

struct Space<CU:FloatingPoint & Codable>: SpaceProtocol {
	
	typealias Axis = IGAxis<IGAxisStyle<CU>>

	var axes: [Axis] = []
	init (axes:[Axis]) {
		self.axes = axes
	}

}
