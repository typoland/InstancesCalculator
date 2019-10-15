import Foundation

public struct Style {
	public var name: String
	public var values: [CoordUnit]
	public init (name: String, values:[CoordUnit]) {
		self.name = name
		self.values = values
	}
}
