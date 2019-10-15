import Foundation

struct Edge: CustomStringConvertible {
	var from:Int
	var to:Int
	init(from: Int, to: Int) {
		self.from = from
		self.to = to
	}
	
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
