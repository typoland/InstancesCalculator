//
//  InstanceGenerator.swift
//  InstancesGenerator
//
//  Created by Łukasz Dziedzic on 15/10/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

public class InstanceGenerator {
	static var instancesChanged = Notification.Name(rawValue: "InstanceGenerator.InstancesChanged")
	enum Errors:Error {
		case axisNotExist(name: String)
		case notEnoughValuesForStyle(name: String, expected: Int)
	}
	
	var space: Space
	
	public init (axes names: [String], bounds: ClosedRange<CoordUnit>) {
		self.space = Space(axes: (0..<names.count).map {Axis(name: names[$0], bounds: bounds)})
	}
	
	init (space:Space) {
		self.space = space
	}
	
	public func addStyle(name: String, to axisName: String, values: [CoordUnit]) throws {
		
		guard let axisIndex = space.axes.firstIndex(where: {$0.name == axisName}) else {
			throw Errors.axisNotExist(name: axisName)
		}
		
		guard values.count.log2 == space.axes.count - 1 else {
			throw Errors.notEnoughValuesForStyle(name: name, expected: 1<<(space.axes.count-1))
			
		}
		let internalValues = values.map { value in
			 InstanceGenerator.convertToInternal(value: value, bounds: space.axes[axisIndex].bounds)
		}
		
		let style = Style(name: name, values: internalValues)
		space.axes[axisIndex].styles.append(style)
		
	}
	
	static func convertToInternal(value:CoordUnit, bounds:ClosedRange<CoordUnit>) -> CoordUnit {
		let result = (value - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
		//print ("To Internal", bounds, value, result)
		return result
	}
	
	static func convertfromInternal(value:CoordUnit, bounds:ClosedRange<CoordUnit>) -> CoordUnit {
		let result = (bounds.upperBound - bounds.lowerBound) * value + bounds.lowerBound
		//print ("From Internal", bounds, value, result)
		return result
	}
	
	public var instances: [(instanceName:String, coordinates:[(axis:String, value:CoordUnit)])] {
		var result:[(instanceName:String, coordinates:[(axis:String, value:CoordUnit)])]  = []
		space.distributeAxes()
		for style in space.instances {
			let coordinates = (0..<style.coordinates.count).map {
				(space.axes[$0].name,
				 InstanceGenerator.convertfromInternal(value: style.coordinates[$0],
									 bounds: space.axes[$0].bounds) )
			}
			
			result.append((instanceName: style.name, coordinates:coordinates))
		}
		return result
	}
	
}
