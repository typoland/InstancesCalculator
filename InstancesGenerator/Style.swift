import Foundation

struct Style {
	var name: String
	var values: [CoordUnit]
	init (name: String, values:[CoordUnit]) {
		self.name = name
		self.values = values
	}
	
	mutating func addValuesForNewAxis() {
		values = values+values
	}
	
	mutating func removeValuesForLastAxis() {
		values = Array(values[0..<values.count/2])
	}
}
