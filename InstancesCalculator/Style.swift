import Foundation

struct IGStyle<T:FloatingPoint & Codable> : AxisInstanceProtocol {
	typealias CoordUnit = T
	var name: String
	var values: [CoordUnit]
	init (name: String, values:[CoordUnit]) {
		self.name = name
		self.values = values
	}
}


extension AxisInstanceProtocol {

	mutating func addValuesForNewAxis() {
		values = values+values
	}
	
	mutating func removeValuesForLastAxis() {
		values = Array(values[0..<values.count/2])
	}
}
