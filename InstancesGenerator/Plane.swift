import Foundation


public struct Plane: CustomStringConvertible {
	public var edgesA: (Edge, Edge)
	public var edgesB: (Edge, Edge)
	public init (edgesA: (Edge, Edge), edgesB:(Edge, Edge)) {
		self.edgesA = edgesA
		self.edgesB = edgesB
	}
	public var description: String {
		return "Plane: \(edgesA), \(edgesB)"
	}
	
	public var belongsToAxes: (Int, Int) {
		return ((edgesA.0.from ^ edgesA.0.to).log2!, (edgesB.0.from ^ edgesB.0.to ).log2!)
	}
}
