import Foundation

public struct Edge: CustomStringConvertible {
	public var from:Int
	public var to:Int
	public init(from: Int, to: Int) {
		self.from = from
		self.to = to
	}
	
	public var axisNr: Int {
		return (from ^ to).log2!
	}
	
	public var axisAndStyleValueIndex : (axis:Int, styleValueIndex:Int) {
		let currentAxis = axisNr
		return (axis:currentAxis,
				styleValueIndex: from.deleteBit(currentAxis))
	}
	
	public var description:String {
		return "\(from)⟷\(to)"
	}
}
