import Foundation

infix operator <<>
infix operator %%

public func <<> (lhs: Int, rhs:(size: Int, bits: Int)) -> Int {
	return lhs.rotate(size: rhs.size, bits: rhs.bits)
}

public func %% (_ a: Int, _ n: Int) -> Int {
	precondition(n > 0, "modulus must be positive")
	let r = a % n
	return r >= 0 ? r : r + n
}


prefix operator ~
///for debug only
public extension Double {
	static prefix func ~ (rhs: Double) -> String {
		return String(format:"%0.4f", rhs)
	}
}
postfix operator  |<>|

//public extension Array {
//	static postfix func |<>| (lhs: inout Array) {
//		let length = lhs.count
//		precondition ((length/2).isLog2, "Must be divided by 4")
//		let segmentSize = length/4
//		let a = lhs[0..<segmentSize]
//		let b = lhs[segmentSize..<segmentSize * 2]
//		let c = lhs[segmentSize * 2..<segmentSize * 3]
//		let d = lhs[segmentSize * 3..<length]
//		lhs = Array(a) + Array(c) + Array(b) + Array(d)
//	}
//}
//
//public extension String {
//	static prefix func ~ (rhs: String) -> String {
//		return "\(rhs)"
//	}
//}

extension Array where Element: FloatingPoint {
	var average: Element {
		return self.reduce(into:Element.zero, {$0+=$1})/Element(self.count)
	}
}

extension Int {
	
	/**I hope it's fast log2 for integers. If it's log returns log if not returns nil
	*/
	var log2:Int? {
		var i = -1
		var z = self
		while z > 0 {
			z = z >> 1
			i += 1
		}
		return 1<<i == self ? i : nil
	}
	var isLog2:Bool {
		return self.log2 != nil
		
	}
	func pad(_ toSize: Int) -> String {
		let string = String(self, radix: 2)
		var padded = string
		for _ in 0..<(toSize - string.count) {
			padded = "0" + padded
		}
		return padded
	}
	
	func rotate (size: Int, bits: Int) -> Int {
		let mask = (1<<size)-1
		let shift = ( bits % size )
		let a = (self << shift) & mask
		let b = (self & mask) >> (size - shift)
		return a | b
	}
	
	func deleteBit (_ bit:Int) -> Int {
		let exp = Int.max//(1<<8)-1//
		let rightMask = (1<<(bit))-1
		let a = self & rightMask
		let leftMask = (exp &<< bit) & exp
		let b = (self >> 1) & leftMask
		return a | b
	}
}
