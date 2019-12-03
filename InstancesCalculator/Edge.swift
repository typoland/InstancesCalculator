import Foundation
protocol EdgeProtocol {
	var from:Int {get set}
	var to:Int {get set}
}

extension EdgeProtocol {
	var axisNr: Int {
		return (from ^ to).log2!
	}
	
	var axisAndStyleValueIndex : (axis:Int, styleValueIndex:Int) {
		let currentAxis = axisNr
		return (axis:currentAxis,
				styleValueIndex: from.deleteBit(currentAxis))
	}
	
	var description:String {
		return "\(from)⟷\(to)"
	}
}


struct Edge: EdgeProtocol, CustomStringConvertible {
	var from:Int
	var to:Int
	init(from: Int, to: Int) {
		self.from = from
		self.to = to
	}
	
}
