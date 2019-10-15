import Foundation

public struct Axis: CustomStringConvertible {
	
	public var name: String
	public var styles: [Style]
	public init (name:String, styles:[Style] = []) {
		self.name = name
		self.styles = styles
	}
	
	public var description: String {
		return "\"\(name)\""
	}
}
