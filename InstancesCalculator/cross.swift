import Foundation
infix operator ❖
func crossEdge <F:FloatingPoint>(x1:F,
								 x2:F,
								 y1:F,
								 y2:F)
	-> (F, F) {
		
		let mul = (x1 -  x2) * (y1 - y2) - 1
		let x =  (x1 * y1 - x1 - x2 * y1 ) / mul
		let y = (x1 * y1 - y1 - x1 * y2) / mul
		return (x:x, y:y)
}
func ❖ <F:FloatingPoint>(lhs:(F,F), rhs:(F,F)) -> (F,F) {
	return crossEdge (x1: lhs.0, x2: lhs.1, y1: rhs.0, y2: rhs.1)
}


func ❖ <T:FloatingPoint>(lhs: Pair<T>, rhs: Pair<T>) -> Pair<T> {	
	let (a,b) = (lhs.a, lhs.b) ❖ (rhs.a, rhs.b)
	return Pair(a: a, b: b)
}
