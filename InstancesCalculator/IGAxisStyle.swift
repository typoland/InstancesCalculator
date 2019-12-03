import Foundation

struct IGAxisStyle<T:FloatingPoint & Codable> : AxisInstanceProtocol {
	typealias CoordUnit = T
	var name: String
	var values: [CoordUnit]
	init (name: String, values:[CoordUnit]) {
		self.name = name
		self.values = values
	}
}


