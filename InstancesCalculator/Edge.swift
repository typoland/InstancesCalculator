import Foundation
protocol EdgeProtocol {
	var from: Int {get set}
	var to: Int {get set}
	init(from: Int, to: Int)
}

extension EdgeProtocol {
	static func allEdgesForSpace(_ dimensions: Int) -> [[Self]]{
		var result:[[Self]] = []
		let verticesNr = 1<<dimensions
		for axisNr in (0..<dimensions) {
			var axisResult:[Self] = []
			for vertexNr in 0 ..< verticesNr>>1 {
				let v1 = (vertexNr << 1)
				let v2 = ((vertexNr << 1) + 1)
				let b1 = v1  <<> (dimensions, axisNr)
				let b2 = v2  <<> (dimensions, axisNr)
				axisResult.append(Self(from:b1, to:b2))
			}
			result.append(axisResult)
		}
		return result
	}
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
