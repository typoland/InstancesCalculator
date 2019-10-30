import Foundation


struct IGAxis<AI: AxisInstanceProtocol >: AxisProtocol, CustomStringConvertible {

	
	typealias AxisInstance = AI

	var name: String
	var styles: [AxisInstance]
	var bounds: ClosedRange<AxisInstance.CoordUnit>
	var distribution: AI.CoordUnit? = nil
	
	init (name:String, bounds: ClosedRange<AxisInstance.CoordUnit>, styles:[AxisInstance] = []) {
		self.name = name
		self.bounds = bounds
		self.styles = styles
	}
	
	var description: String {
		return "\"\(name)\""
	}
}


extension AxisProtocol {
	mutating func setValue(_ value: AxisInstance.CoordUnit, of styleName: String, in domainIndex: Int) {
		guard let styleIndex = styles.firstIndex(where: {$0.name == styleName }) else {return}
		guard domainIndex < styles[styleIndex].values.count else {return}
		styles[styleIndex].values[domainIndex] = value
		
	}
	
	mutating func addValuesForNewAxis() {
		(0..<styles.count).forEach {styles[$0].addValuesForNewAxis()}
	}
	
	mutating func removeValuesForLastAxis() {
		(0..<styles.count).forEach {styles[$0].removeValuesForLastAxis()}
	}
}
