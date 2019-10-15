import Foundation
struct Pair<T> : CustomStringConvertible {
	var a: T
	var b: T
	var description: String {
		return "<\"\(a)\", \"\(b)\">"
	}
	init (a:T, b:T) {
		self.a = a
		self.b = b
	}
}
