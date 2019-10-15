import Foundation
struct Axis: CustomStringConvertible {
	
	var name: String
	var styles: [Style]
	var bounds: ClosedRange<CoordUnit>
	
	init (name:String, bounds: ClosedRange<CoordUnit>, styles:[Style] = []) {
		self.name = name
		self.bounds = bounds
		self.styles = styles
	}
	
	var description: String {
		return "\"\(name)\""
	}
}
