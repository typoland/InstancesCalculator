import Foundation

extension String {
	static var zero: String {
		return ""
	}
}

public typealias CoordUnit = Double


//public enum EdgePosition :Int, CustomStringConvertible {
//	case lower = 0, upper
//	public var description: String {
//		return "\(self == .upper ? "↑" : "↓")"
//	}
//}
//
//public typealias AxisEdgePosition = (axis:Axis, edge:EdgePosition)
//public typealias Domain = [AxisEdgePosition]
