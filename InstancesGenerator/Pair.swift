import Foundation
public struct Pair<T> : CustomStringConvertible {
	public var a: T
	public var b: T
	public var description: String {
		return "<\"\(a)\", \"\(b)\">"
	}
	public init (a:T, b:T) {
		self.a = a
		self.b = b
	}
}
infix operator |><|

public extension Pair {
	static func |><| ( lhs: inout Pair, rhs:inout Pair) {
		let a = rhs.a
		rhs.a = lhs.b
		lhs.b = a
	}
}
