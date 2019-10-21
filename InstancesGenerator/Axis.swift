import Foundation


struct Axis: CustomStringConvertible {
	
	var name: String
	var styles: [Style]
	var bounds: ClosedRange<CoordUnit>
	var distribution: Double = 1.0
	
	init (name:String, bounds: ClosedRange<CoordUnit>, styles:[Style] = []) {
		self.name = name
		self.bounds = bounds
		self.styles = styles
	}
	
	var description: String {
		return "\"\(name)\""
	}
	
	mutating func setValue(_ value: CoordUnit, of styleName: String, in domainIndex:Int) {
		guard let styleIndex = styles.firstIndex(where: {$0.name == styleName }) else {return}
		guard domainIndex < styles[styleIndex].values.count else {return}
		styles[styleIndex].values[domainIndex] = value
		
	}
}
