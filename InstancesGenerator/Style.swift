import Foundation

struct Style {
	var name: String
	var values: [CoordUnit]
	init (name: String, values:[CoordUnit]) {
		self.name = name
		self.values = values
	}
}
