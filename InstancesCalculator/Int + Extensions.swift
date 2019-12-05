import Foundation

infix operator <<>
infix operator %%
/**
Rotate bits left
- parameter lhs: how many left bits will be affected
- parameter rhs: number of positions to rotate
- returns: Int with `lhs` right bits rotates about `rhs` postitions
*/

public func <<> (lhs: Int, rhs:(size: Int, bits: Int)) -> Int {
	return lhs.rotate(size: rhs.size, bits: rhs.bits)
}


///c-like mod, no negative result
public func %% (_ a: Int, _ n: Int) -> Int {
	precondition(n > 0, "modulus must be positive")
	let r = a % n
	return r >= 0 ? r : r + n
}


extension Array where Element: FloatingPoint {
	var average: Element {
		return self.reduce(into:Element.zero, {$0+=$1})/Element(self.count)
	}
}

extension Int {
	
	/**I hope it's fast log2 for integers.
	- returns: if `self` is  2^n and `n` is `Int` than returns `n`, if not, returns `nil`
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
	/**
	- returns: if number is log 2 then returns true*/
	var isLog2:Bool {
		return self.log2 != nil
	}
	
	/**
	Rotate bits left.
	- parameter size: **Int** describing how many bits will be rotated - xx10001
	- parameter bits: **Int** describing how far will be moved. Left bits will be moved to right - xx00110
	*/
	func rotate (size: Int, bits: Int) -> Int {
		let mask = (1<<size)-1
		let shift = ( bits % size )
		let a = (self << shift) & mask
		let b = (self & mask) >> (size - shift)
		return a | b
	}
	/**
	Deletes bit. Bits on left will be moved one position right
	- parameter bit: which bit disappear
	*/
	func deleteBit (_ bit:Int) -> Int {
		let exp = Int.max//(1<<8)-1//
		let rightMask = (1<<(bit))-1
		let a = self & rightMask
		let leftMask = (exp &<< bit) & exp
		let b = (self >> 1) & leftMask
		return a | b
	}
}

extension String {
	func condenseWhitespace() -> String {
		let components = self.components(separatedBy: .whitespacesAndNewlines)
		return components.filter { !$0.isEmpty }.joined(separator: " ")
	}
}
